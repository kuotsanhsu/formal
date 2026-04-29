# Gödel Knowledge Map

This is the durable map for the long project of understanding Gödel's first incompleteness theorem through Lean 4 formalization.

## North Star

Understand Gödel's first incompleteness theorem deeply enough to formalize a clear version of it in Lean 4, with each informal bridge replaced by explicit definitions and proofs.

## Leitmotifs

- Lean as Begriffsschrift / Characteristica Universalis rather than ordinary programming.
- Formalization as a way to test whether an apparent understanding survives exact notation.

These are not side ideas. They govern the whole project: explanations, source selection, Lean design, and the choice of what counts as progress.

## Current Lean Artifact

`Logic/Gödel.lean` is a small work-in-progress based on Nagel, Newman, and Hofstadter's presentation. It currently contains:

- a computational prime sieve;
- a Gödel numbering function from lists of symbol codes to products of prime powers;
- a small object language of arithmetic terms and predicates;
- a quotation-like syntax for PM-style examples;
- a few computed examples.

It does not yet contain the proof infrastructure needed for incompleteness: syntax decoding, substitution, free-variable analysis, a proof calculus, representability, a provability predicate, the diagonal lemma, or the first incompleteness theorem.

## Source Roles To Confirm

The user's intended role for each PDF is pending. Current provisional grouping:

- Core expository route: Nagel/Newman/Hofstadter, Peter Smith, Hirzel.
- Mechanized proof route: O'Connor, Paulson, Kirst/Peters.
- Diagonalization and self-reference route: Gaifman, Smullyan, Yanofsky, Abramsky/Zvesper.
- Logic and proof-assistant background: Avigad, Pfenning, Wadler, Weaver, Chlipala, Winterhalter.
- Possibly peripheral but relevant to formal semantics: O'Connor on Simplicity.

## Working Norms

- Keep Gödel's first incompleteness theorem as the main project.
- Use tangents only when they clarify the main project or deserve separate tracking.
- Consolidate only serious, recurring, or structurally important ideas.
- Discuss major memory consolidations before adding them here.
- Remind the user to consider a git commit after coherent milestones, especially after updates to these knowledge documents or meaningful Lean formalization progress.

## Open Decisions

- Which proof route should be primary: traditional arithmetization, Rosser, abstract computability, HF set theory, or another route?
- How faithful should the Lean formalization remain to Nagel/Newman versus using cleaner modern syntax and proof infrastructure?
- What minimal theorem statement should count as the first major destination?
