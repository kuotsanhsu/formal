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

The desired approach is to continue the embedded PM target language as a Lean DSL using a custom syntax category. It does not yet contain the proof infrastructure needed for incompleteness: syntax decoding, substitution, free-variable analysis, a proof calculus, representability, a provability predicate, the diagonal lemma, or the first incompleteness theorem.

## Source Map

The user's intended role for the PDFs is now recorded in `docs/Gödel-Source-Map.md`.

Primary intention: complete an implementation of Gödel's first incompleteness theorem based on Gödel's original proof as outlined in Nagel, Newman, and Hofstadter, using O'Connor's Coq formalization as the primary mechanized example and Paulson's Isabelle formalization as the secondary mechanized example.

## Working Norms

- Keep Gödel's first incompleteness theorem as the main project.
- Use tangents only when they clarify the main project or deserve separate tracking.
- Consolidate only serious, recurring, or structurally important ideas.
- Discuss major memory consolidations before adding them here.
- Remind the user to consider a git commit after coherent milestones, especially after updates to these knowledge documents or meaningful Lean formalization progress.

## Open Decisions

- How faithful should the Lean formalization remain to Nagel/Newman versus using cleaner modern syntax and proof infrastructure?
- What minimal theorem statement should count as the first major destination?
- How much of O'Connor's Coq infrastructure should be mirrored directly versus adapted to Lean-native idioms?
