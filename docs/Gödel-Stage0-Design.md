# Gödel Stage 0 Design

Stage 0 fixes the target and the layer discipline before we expand the Lean development.

## Target

The first concrete target is not the full first incompleteness theorem. The first target is to construct a Gödel sentence for a specific PM-flavored arithmetic theory, modeled on Nagel, Newman, and Hofstadter's `~ (∃x) Dem (x, Sub (n, 17, n))`.

The working reading of "PM-flavored" is not literal historical Principia Mathematica. It means a first-order arithmetic target language with Nagel/Newman/Hofstadter-style notation and enough arithmetic to carry the arithmetization argument.

## Layer Discipline

The project must keep the following layers distinct.

1. Lean metatheory: Lean definitions of syntax, substitution, coding, proof checking, and theorems about them.
2. Object language: the PM-flavored arithmetic language whose terms and formulas are represented as Lean datatypes.
3. Gödel codes: natural numbers that encode object-language expressions and proof sequences.
4. Internal arithmetic representation: object-language formulas that express numerical relations such as substitution-on-codes and proof-checking-on-codes.

> [!WARNING]
> The dangerous ambiguity is to treat `Sub` or `Dem` as if it simply lives at one level. It does not. `Sub` starts as metalevel substitution on syntax, then becomes a numerical operation or relation on Gödel codes, then becomes an object-language formula representing that operation or relation. `Dem` starts as metalevel proof checking, then becomes a numerical relation on proof and formula codes, then becomes an object-language formula representing that relation.

## Current Lean File

`Logic/Gödel.lean` is useful but should be treated as a prototype. One immediate naming issue is that the current `Formula` datatype is really the datatype of arithmetic terms, while the current `Predicate` datatype is closer to the datatype of formulas. A cleaner internal representation should probably use names like `Term` and `Formula`, with the custom DSL becoming notation over those datatypes.

## Initial Internal Syntax

A likely first internal representation:

- variables as de Bruijn indices, represented by natural numbers;
- terms with constructors for variables, zero, successor, addition, and multiplication;
- formulas with constructors for equality, negation, disjunction, implication, existential quantification, and later whatever predicates or abbreviations are needed for `Dem` and `Sub`;
- quotation notation as a convenience layer, not as the foundation.

Binding decision: use de Bruijn indices internally. Named variables are closer to Nagel/Newman/Hofstadter and the current file, but substitution will become unwieldy if names are the core representation.

PHOAS note: parametric higher-order abstract syntax can be cleaner for some binding and substitution metatheory, but it is a poor first internal representation for this project because Gödel numbering requires syntax to be first-order data. With PHOAS, object binders are represented using Lean binders, which makes quotation, coding, decoding, primitive-recursive syntax operations, and proof checking harder to expose as numerical data. PHOAS may still be useful as a convenience layer or comparison later, but de Bruijn should be the coded core.

Surface layer: named variables can be layered on top of de Bruijn indices using the DSL. The parser/elaborator for the object language can maintain a local name context and translate names to indices. Later, Lean widgets may help display de Bruijn syntax back as readable named syntax or visualize binding and substitution.

## Initial Module Plan

- `Logic/Gödel/Syntax.lean`: object-language variables, terms, formulas, and basic recursion principles.
- `Logic/Gödel/Notation.lean`: custom syntax and examples for the PM-flavored DSL.
- `Logic/Gödel/Coding.lean`: symbol codes, expression codes, sequence coding, and decoding properties.
- `Logic/Gödel/PrimitiveRecursive.lean`: primitive-recursive functions and relations needed for syntactic operations.
- `Logic/Gödel/Substitution.lean`: metalevel substitution and later substitution-on-codes.
- `Logic/Gödel/Proof.lean`: proof calculus, proof checking, and `Dem` at the metalevel and code level.
- `Logic/Gödel/Representability.lean`: formulas representing primitive-recursive functions and relations.
- `Logic/Gödel/Diagonal.lean`: diagonalization and construction of the Gödel sentence.
- `Logic/Gödel/Examples.lean`: worked examples from Nagel/Newman/Hofstadter.

This plan is provisional. The module structure should change if O'Connor's Coq development suggests a better decomposition.

## Widget Note

Lean widgets may become useful later for visualizing syntax trees, substitutions, proof objects, or large Gödel codes. This should be revisited when textual notation starts obscuring structure rather than clarifying it.

## Stage 0 Completion Criteria

Stage 0 is complete when we have split the current file, written the first small Lean module for de Bruijn-based syntax, and added enough notation or examples to confirm that the internal representation can still be read in a Nagel/Newman/Hofstadter style.
