/-
Go to "https://live.lean-lang.org/#project=mathlib-stable", and select "Load" > "Load from URL" >
"https://gist.githubusercontent.com/kuotsanhsu/9eb8aabe1701fc16b7ac4066ddf70a89/raw/Godel.lean"

# Formalization of "Gödel's Proof" by Ernest Nagel and James R. Newman

* Work in Progress!
* Implemented Gödel numbering as in chapter VIII-A. Punctuation marks `(`, `)`, `,` are not numbered
  because they are mere artifacts in the concrete syntax. The rest are the same.
-/
import Mathlib.Data.Nat.Prime.Defs

set_option autoImplicit false
set_option linter.style.nativeDecide false

/-- Sieve of Eratosthenes. Returns a list of primes up to length.
* No correctness proof, but tested up to the first 58 primes.
* Performance could be improved:
  1. Reuse the `primes` array between calls.
  2. Apply wheel factorization as in https://github.com/ykonstant1/esiv
-/
def Nat.sieve : (length : Nat) → Array Nat
  | 0 => #[]
  | length + 1 => Id.run do
    let mut primes := #[2]
    let mut sqrt := 1
    let mut sqrtSquare := 1
    let mut n := 1
    for _ in [0:length] do
      repeat
        n := n + 2
        if sqrtSquare < n then
          sqrt := sqrt + 1
          sqrtSquare := sqrt * sqrt
      until isPrime primes sqrt n
      primes := primes.push n
    return primes
where
  isPrime (primes : Array Nat) (sqrt n : Nat) : Bool := Id.run do
    for p in primes do
      if p > sqrt then
        break
      else if n % p == 0 then
        return false
    return true

example : Nat.sieve 0 = #[] := rfl
example : Nat.sieve 1 = #[2] := by native_decide
example : Nat.sieve 2 = #[2, 3] := by native_decide
example : Nat.sieve 3 = #[2, 3, 5] := by native_decide

/-- https://oeis.org/A000040 -/
def A000040 : Array Nat := #[
    2,   3,   5,   7,  11,  13,  17,  19,  23,  29,
   31,  37,  41,  43,  47,  53,  59,  61,  67,  71,
   73,  79,  83,  89,  97, 101, 103, 107, 109, 113,
  127, 131, 137, 139, 149, 151, 157, 163, 167, 173,
  179, 181, 191, 193, 197, 199, 211, 223, 227, 229,
  233, 239, 241, 251, 257, 263, 269, 271,
]
example : A000040.size = 58 := rfl
example : Nat.sieve A000040.size = A000040 := by native_decide

namespace Gödel

def number (code : List Nat) : Nat :=
  let code := code.toArray
  (Nat.sieve code.size).zipWith Nat.pow code |>.foldl Nat.mul 1

/-- A prime greater than 12. -/
abbrev PrimeGt12 := { n : Nat // n > 12 ∧ n.Prime }

/-- Numerical variables: `x`, `y`, `z` -/
structure NumbVar where
  prime : PrimeGt12

def NumbVar.code (x : NumbVar) : List Nat := [x.prime]

/-!
/-- Sentential variables: `p`, `q`, `r` -/
structure SentVar where
  prime : PrimeGt12

def SentVar.code (p : SentVar) : List Nat := [p.prime ^ 2]
-/

inductive Formula
  | zero
  | s   (x : Formula)
  | add (x y : Formula)
  | mul (x y : Formula)
  | var (x : NumbVar)

def Formula.code : Formula → List Nat
  | zero => [6]
  | s x => 7 :: x.code
  | add x y => x.code ++ 11 :: y.code
  | mul x y => x.code ++ 12 :: y.code
  | var x => x.code

instance : Coe NumbVar Formula where
  coe := .var

/-!
/-- Predicate variables: `P`, `Q`, `R` -/
structure PredVar where
  prime : PrimeGt12

def PredVar.code (P : PredVar) : List Nat := [P.prime ^ 3]
-/

inductive Predicate
  | not (P : Predicate)
  | or  (P Q : Predicate)
  | imp (P Q : Predicate)
  | ex  (x : NumbVar) (P : Predicate)
  | eq  (x y : Formula)

def Predicate.code : Predicate → List Nat
  | not P => 1 :: P.code
  | or  P Q => P.code ++ 2 :: Q.code
  | imp P Q => P.code ++ 3 :: Q.code
  | ex  x P => 4 :: x.code ++ P.code
  | eq  x y => x.code ++ 5 :: y.code

def Formula.ofNat : Nat → Formula
  | 0 => zero
  | n + 1 => s (ofNat n)

-- ‘’“”

declare_syntax_cat PM
syntax num : PM
syntax:max "s" PM : PM
syntax PM "×" PM : PM
syntax ident : PM
syntax "(" PM ")" : PM
syntax "~" PM : PM
syntax "(" "∃" ident ")" PM : PM
-- syntax "∃" ident PM : PM
syntax PM "=" PM : PM
syntax "‘" PM "’" : term

macro_rules
  | `(‘$n:num’) => ``(Formula.ofNat $n)
  | `(‘s $x:PM’) => ``(Formula.s ‘$x’)
  | `(‘$x:PM × $y:PM’) => ``(Formula.mul ‘$x’ ‘$y’)
  | `(‘$x:ident’) => ``(Formula.var $x)
  | `(‘($P:PM)’) => ``(‘$P’)
  | `(‘~$P:PM’) => ``(Predicate.not ‘$P’)
  | `(‘(∃ $x:ident) $P:PM’) => ``(Predicate.ex $x ‘$P’)
  -- | `(‘∃ $x:ident $P:PM’) => ``(Predicate.ex $x ‘$P’)
  | `(‘$x:PM = $y:PM’) => ``(Predicate.eq ‘$x’ ‘$y’)

namespace Example

def x : NumbVar where prime := ⟨13, .refl, by native_decide⟩
def y : NumbVar where prime := ⟨17, by native_decide, by native_decide⟩
def P := ‘(∃ x) (x = s y)’
example : P = .ex x (.eq x (.s y)) := rfl
example : P.code = [4, 13, 13, 5, 7, 17] := rfl

def Q := ‘0 = 0’
example : Q = .eq .zero .zero := rfl
example : Q.code = [6, 5, 6] := rfl
example : number Q.code = 243_000_000 := by native_decide

example : ‘~(0 = 0)’.code = [1, 6, 5, 6] := rfl
def a := number ‘~(0 = 0)’.code
def z : NumbVar where prime := ⟨19, by native_decide, by native_decide⟩
example := ‘(∃ z) (y = z × x)’

end Example

end Gödel
