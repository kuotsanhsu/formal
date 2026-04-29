# Gödel Course Plan

This is the staged course plan for understanding Gödel's first incompleteness theorem through Lean 4 formalization.

## Calibrated Background

The user is familiar with first-order logic, ZFC, basic metatheory, Peano arithmetic, structural recursion, well-founded recursion, computation theory, the halting problem, Curry-Howard, dependent types, Lean 4, and reading Coq. The user is not yet familiar with primitive recursion. The user has substantial Lean 4 experience, including Schur decomposition, the determinant-one property of the spin homomorphism, correctness and time complexity proofs for longest common subsequence and regular expression matching, and Lean 4 work through the first volume of Software Foundations.

Implication: the course should not spend much time on beginner Lean or elementary first-order logic. It should focus on primitive recursion, representability, arithmetized syntax, proof predicates, diagonalization, and the engineering of variables, substitution, and proof systems in Lean 4.

## Teaching Protocol

- Before each stage, ask the user to clarify or approve the local plan.
- During each stage, use Lean 4 to make concepts precise.
- After each stage, give a short quiz on key concepts.
- Track side ideas separately so tangents do not erase the main line.
- Periodically suggest git commit points, but let the user perform git operations.

## Route

Primary route: Gödel's original proof as outlined by Nagel, Newman, and Hofstadter, filled in using O'Connor's Coq formalization as the main mechanized reference and Paulson's Isabelle formalization as a secondary reference.

Non-route: incompleteness via the halting problem is useful context but not the main path.

## Stage 0: Orientation And Design Commitments

Purpose: fix the exact theorem target, object language, proof calculus, and Lean representation strategy.

Questions:

- What should count as the first completed theorem: semantic incompleteness, syntactic incompleteness, essential incompleteness of arithmetic, or a Gödel sentence for a specific theory?
- Should the target theory initially be a PM-flavored arithmetic, Peano arithmetic, Robinson arithmetic, or a custom minimal arithmetic close to O'Connor?
- How faithful should the syntax remain to Nagel/Newman notation versus a cleaner Lean inductive representation?

Deliverable: a short design note and a Lean namespace/module plan.

## Stage 1: Primitive Recursion As The Missing Bridge

Purpose: understand primitive recursive functions as the bridge between effective syntax operations and arithmetical representability.

Important warning: primitive recursion is not just "recursion with restrictions." In this project, it is the hinge between informal syntactic computability and what arithmetic itself can express.

Content:

- Primitive recursion versus structural recursion and well-founded recursion.
- Primitive recursive predicates and relations.
- Closure properties needed for coding syntax.
- Why Gödel needs primitive recursion rather than just informal computability.
- Comparison with Lean/mathlib's `Nat.Primrec` and O'Connor's Coq development.

Lean target: define a small primitive-recursive fragment or map the project onto mathlib's primitive recursion infrastructure, then prove basic closure examples.

## Stage 2: Formal Syntax Of The PM Target Language

Purpose: turn the current DSL into a robust object-language representation.

Content:

- Terms, formulas, variables, contexts, free variables, substitution.
- Object-language syntax versus Lean syntax.
- Named variables, de Bruijn indices, or hybrid representation.
- Lessons from Winterhalter, O'Connor, and Paulson on substitution and binding.

Lean target: extend `Logic/Gödel.lean` or split it into modules for syntax, variables, substitution, and notation.

## Stage 3: Gödel Coding And Decoding

Purpose: make Gödel numbering mathematically useful, not merely computable.

Content:

- Symbol codes, sequence coding, unique decoding, and syntactic well-formedness.
- Prime-power coding versus alternative encodings.
- Relation between Nagel/Newman coding and mechanized encodings in Coq/Isabelle.
- What must be proved about the code, not just computed.

Lean target: prove injectivity/decoding properties or deliberately choose a coding scheme with better proof ergonomics while preserving conceptual fidelity.

## Stage 4: Arithmetization Of Syntax

Purpose: express syntactic operations as arithmetic relations/functions.

Content:

- Substitution on codes.
- Formula formation predicates.
- Proof sequence predicates.
- Primitive recursiveness of syntax operations.
- The correspondence lemma as the major informal-to-formal bridge.

Lean target: define and prove primitive recursiveness or representability for the syntactic operations needed by the diagonal lemma and provability predicate.

## Stage 5: Proof Calculus And Provability

Purpose: formalize the deductive system enough to define "x is a proof of y" and "y is provable".

Content:

- Choice of axioms and inference rules.
- Encoding proof sequences.
- Provability predicate.
- Soundness assumptions needed for the first theorem.
- Difference between semantic truth, theoremhood, consistency, ω-consistency, and representability.

Lean target: implement proof objects or proof sequences and the primitive recursive proof-checking predicate.

## Stage 6: Diagonalization

Purpose: formalize the fixed-point construction that produces self-reference.

Content:

- Diagonal lemma.
- Relationship among Gödel, Carnap, Lawvere, Smullyan, Yanofsky, and Gaifman presentations.
- The exact point where substitution into one's own code occurs.

Lean target: construct the Gödel sentence for the chosen provability predicate.

## Stage 7: First Incompleteness Theorem

Purpose: prove the target theorem.

Content:

- Unprovability of the Gödel sentence under the chosen consistency/soundness hypothesis.
- Unprovability of its negation under the chosen stronger hypothesis, if pursued.
- Comparison with O'Connor and Paulson.

Lean target: a theorem statement and proof in the project namespace.

## Stage 8: Review And Refinement

Purpose: compare what was formalized against the original philosophical and mathematical intention.

Content:

- What Nagel/Newman left implicit.
- What O'Connor and Paulson solve differently.
- Whether the Lean development clarified or distorted the theorem.
- Possible extension toward Rosser, second incompleteness, or alternative diagonalization frameworks.
