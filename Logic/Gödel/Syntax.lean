import Mathlib.Data.Nat.Basic

set_option autoImplicit false

namespace Gödel
namespace Syntax

/-- De Bruijn variable indices for the PM-flavored object language. -/
abbrev Var := Nat

/-- Arithmetic terms in the PM-flavored object language. -/
inductive Term where
  | var : Var → Term
  | zero : Term
  | succ : Term → Term
  | add : Term → Term → Term
  | mul : Term → Term → Term
  deriving Repr, DecidableEq

/-- Formulas in the PM-flavored object language. -/
inductive Formula where
  | eq : Term → Term → Formula
  | not : Formula → Formula
  | or : Formula → Formula → Formula
  | imp : Formula → Formula → Formula
  | ex : Formula → Formula
  deriving Repr, DecidableEq

namespace Term

/-- The object-language numeral for a metalevel natural number. -/
def numeral : Nat → Term
  | 0 => zero
  | n + 1 => succ (numeral n)

/-- Raise free variable indices at or above `cutoff` by `amount`. -/
def liftAbove (cutoff amount : Nat) : Term → Term
  | var x => if cutoff ≤ x then var (x + amount) else var x
  | zero => zero
  | succ t => succ (liftAbove cutoff amount t)
  | add t u => add (liftAbove cutoff amount t) (liftAbove cutoff amount u)
  | mul t u => mul (liftAbove cutoff amount t) (liftAbove cutoff amount u)

/-- Raise every free variable index by `amount`. -/
def lift (amount : Nat) : Term → Term :=
  liftAbove 0 amount

/-- Simultaneous metalevel substitution on terms. -/
def subst (σ : Var → Term) : Term → Term
  | var x => σ x
  | zero => zero
  | succ t => succ (subst σ t)
  | add t u => add (subst σ t) (subst σ u)
  | mul t u => mul (subst σ t) (subst σ u)

end Term

namespace Formula

/-- Extend a substitution under one object-language binder. -/
def substUnder (σ : Var → Term) : Var → Term
  | 0 => .var 0
  | x + 1 => (σ x).lift 1

/-- Raise free variable indices at or above `cutoff` by `amount`. -/
def liftAbove (cutoff amount : Nat) : Formula → Formula
  | eq t u => eq (t.liftAbove cutoff amount) (u.liftAbove cutoff amount)
  | not p => not (liftAbove cutoff amount p)
  | or p q => or (liftAbove cutoff amount p) (liftAbove cutoff amount q)
  | imp p q => imp (liftAbove cutoff amount p) (liftAbove cutoff amount q)
  | ex p => ex (liftAbove (cutoff + 1) amount p)

/-- Raise every free variable index by `amount`. -/
def lift (amount : Nat) : Formula → Formula :=
  liftAbove 0 amount

/-- Simultaneous capture-avoiding metalevel substitution on formulas. -/
def subst (σ : Var → Term) : Formula → Formula
  | eq t u => eq (t.subst σ) (u.subst σ)
  | not p => not (subst σ p)
  | or p q => or (subst σ p) (subst σ q)
  | imp p q => imp (subst σ p) (subst σ q)
  | ex p => ex (subst (substUnder σ) p)

end Formula

namespace Example

open Term Formula

/-- `∃. #0 = #1`, where `#0` is bound and `#1` is the first outer variable. -/
def boundEqOuter : Formula :=
  ex (eq (var 0) (var 1))

example : Term.numeral 3 = succ (succ (succ zero)) := rfl

example : boundEqOuter.subst (fun
    | 0 => zero
    | x + 1 => var (x + 1)) = ex (eq (var 0) zero) := rfl

end Example

end Syntax
end Gödel
