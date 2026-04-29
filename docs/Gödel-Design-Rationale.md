# Gödel Design Rationale

This file records durable rationale for the project route. It is not a general idea log.

## Why Arithmetization Instead Of The Halting-Problem Route

The project should pursue the arithmetization route rather than proving incompleteness via the halting problem. The reason is not that Turing machines are philosophically irrelevant, but that they would introduce a large additional formalization layer. The local pinned mathlib does contain Turing-machine-related files, including `Mathlib/Computability/TuringMachine.lean`, so the claim is not that Lean has no Turing-machine formalization available. The stronger project-specific point is that the target theorem is about syntax, substitution, proof checking, and arithmetic representation; developing a PM-flavored arithmetic DSL is closer to the theorem's internal mechanism and to the user's existing Lean metaprogramming experience.

## Lean-Specific Opportunity

Lean 4 may simplify parts of the arithmetization route in ways that are hard to express on paper. Lean uses one language for proofs, programs, tactics, macros, and metaprogramming. This means the project can use custom syntax categories, DSL elaboration, ordinary programming, proof automation, and verified definitions inside a single environment. The proof assistant can also validate details that would be ambiguous or painfully verbose in prose, provided the layer distinctions remain explicit.

## Encoding Strategy

Classical prime-power Gödel numbering remains conceptually important because it is the route used by Nagel, Newman, Hofstadter, and Gödel's original proof. Still, the Lean development may use list-like or structured intermediate representations when they clarify programming and proofs. The key obligation is to connect any convenient representation back to arithmetic coding and representability, not to fetishize prime products at every implementation layer.

## Main Implementation Theme

Guru-Limao's remark, "Gödel was trying to do programming way before the modern personal computer was invented," is a guiding theme for the implementation. The point is not to reduce Gödel to programming, but to notice that Gödel's proof manipulates syntax, encodes programs of syntactic operations, and makes arithmetic reason about these operations. The Lean development should make this computational content visible.

## Future Comparative Direction

Agda may later be worth comparing with Lean. Lean 4 also supports mixfix notation, so mixfix itself is not the distinction. The sharper notation issue is that Lean notation cannot be used inside the definition that first introduces the thing the notation denotes, while Agda permits constructor names themselves to be mixfix. For example, an Agda object-language formula datatype can introduce `_⇒_` directly as a constructor and use that constructor notation in later constructors or examples:

```agda
data Formula : Set where
  atom : Formula
  _⇒_  : Formula → Formula → Formula
  ∀[_]_ : String → Formula → Formula

example : Formula
example = ∀[ "x" ] atom ⇒ atom
```

No joke, see https://plfa.github.io/Lists/#lists and the "Type theory in type theory using quotient inductive types" paper by Thorsten Altenkirch and Ambrus Kaposi; free access at https://doi.org/10.1145/2837614.2837638

In Lean, the analogous inductive definition must first introduce ordinary constructor names such as `Formula.imp` and `Formula.all`; notation like `φ ⇒ ψ` or `∀' x, φ` has to be declared afterward. Lean 4's strength for this project is its unified proof/program/tactic/macro language and its compilation and linking story. Any Lean-Agda comparison should wait until the Gödel project has produced enough concrete artifacts to compare.
