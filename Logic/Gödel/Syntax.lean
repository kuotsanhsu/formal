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
  | n + 1 => (numeral n).succ

/-- Raise free variable indices at or above `cutoff` by `amount`. -/
def liftAbove (cutoff amount : Nat) : Term → Term
  | var x => if cutoff ≤ x then var (x + amount) else var x
  | zero => zero
  | succ t => (t.liftAbove cutoff amount).succ
  | add t u => add (t.liftAbove cutoff amount) (u.liftAbove cutoff amount)
  | mul t u => mul (t.liftAbove cutoff amount) (u.liftAbove cutoff amount)

/-- Raise every free variable index by `amount`. -/
def lift (amount : Nat) : Term → Term :=
  fun t => t.liftAbove 0 amount

/-- Simultaneous metalevel substitution on terms. -/
def subst (σ : Var → Term) : Term → Term
  | var x => σ x
  | zero => zero
  | succ t => (t.subst σ).succ
  | add t u => add (t.subst σ) (u.subst σ)
  | mul t u => mul (t.subst σ) (u.subst σ)

end Term

namespace Formula

/-- Extend a substitution under one object-language binder. -/
def substUnder (σ : Var → Term) : Var → Term
  | 0 => .var 0
  | x + 1 => (σ x).lift 1

/-- Raise free variable indices at or above `cutoff` by `amount`. -/
def liftAbove (cutoff amount : Nat) : Formula → Formula
  | eq t u => eq (t.liftAbove cutoff amount) (u.liftAbove cutoff amount)
  | not p => not (p.liftAbove cutoff amount)
  | or p q => or (p.liftAbove cutoff amount) (q.liftAbove cutoff amount)
  | imp p q => imp (p.liftAbove cutoff amount) (q.liftAbove cutoff amount)
  | ex p => ex (p.liftAbove (cutoff + 1) amount)

/-- Raise every free variable index by `amount`. -/
def lift (amount : Nat) : Formula → Formula :=
  fun p => p.liftAbove 0 amount

/-- Simultaneous capture-avoiding metalevel substitution on formulas. -/
def subst (σ : Var → Term) : Formula → Formula
  | eq t u => eq (t.subst σ) (u.subst σ)
  | not p => not (p.subst σ)
  | or p q => or (p.subst σ) (q.subst σ)
  | imp p q => imp (p.subst σ) (q.subst σ)
  | ex p => ex (p.subst (substUnder σ))

end Formula

namespace Example

open Term Formula

def «∃ x, x = y» : Formula := ex (eq (var 0) (var 1))

example : numeral 3 = zero.succ.succ.succ := rfl

example : «∃ x, x = y».subst (fun _ => zero.succ) = ex (eq (var 0) zero.succ) := rfl

end Example

end Syntax
end Gödel
