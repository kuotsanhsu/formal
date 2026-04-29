# Gödel Source Map

This file records the intended roles of the PDFs and the Lean source file for the Gödel formalization project.

## Usage Classes

- Logical background for Lean 4, constructive logic, Curry-Howard, semantics, and proof-assistant methodology.
- Gödel's original proof and modern exposition of the first incompleteness theorem.
- Existing mechanized formalizations in Coq and Isabelle, used as implementation references rather than as endpoints.
- Diagonalization and self-reference, used to understand the conceptual engine behind the theorem.

## Primary Route

Complete an implementation of Gödel's first incompleteness theorem based on Gödel's original proof as outlined in Nagel, Newman, and Hofstadter, using O'Connor's Coq formalization as the primary mechanized example and Paulson's Isabelle formalization as the secondary mechanized example.

Do not pursue the halting-problem route as the main path, even where sources such as Kirst and Peters explain incompleteness that way.

## PDF Roles

- Abramsky and Zvesper, `From Lawvere to Brandenburger-Keisler`: for understanding diagonalization.
- Avigad, `Classical and Constructive Logic`: for using Lean 4, especially its constructive/intuitionistic logical foundation. Lean 4 should be understood as a serious computer mechanization of such a logical system.
- Chlipala, `Formal Reasoning about Programs`: for using Lean 4 with the right proof-programming mindset. The concurrent separation logic material is a distinctive reference point.
- Gaifman, `Naming and Diagonalization, from Cantor to Gödel to Kleene`: for understanding diagonalization.
- Hirzel, `Gödel's Original Proof Modernized`: reference for Gödel's original proof.
- Kirst and Peters, `Gödel's Theorem Without Tears`: Coq formalization of incompleteness via the halting problem. Read for Coq formalization lessons, not as the intended proof route.
- Nagel, Newman, and Hofstadter, `Gödel's Proof`: the reference approach. Important details such as primitive recursion and the correspondence lemma are only mentioned there, so they must be filled in from other sources.
- O'Connor, `Essential Incompleteness of Arithmetic Verified by Coq`: main Coq formalization reference and a distilled form of O'Connor's thesis.
- O'Connor, `Incompleteness and Completeness`: complete Coq formalization reference, but the PDF is password-protected from copying text.
- O'Connor, `thesis without TOC`: use this instead of the protected thesis PDF because it is less problematic and smaller without loss of content.
- O'Connor, `Simplicity; A New Language for Blockchains`: blockchain is not the concern, but the paper contains interesting Coq usage to learn from.
- Paulson, `A Mechanised Proof of Gödel's Incompleteness Theorems using Nominal Isabelle`: main Isabelle formalization reference.
- Pfenning, `Constructive Logic`: logical foundation of Lean 4.
- Smith, `An Introduction to Gödel's Theorems`: canonical modern reference for Gödel's first and second incompleteness theorems. It contains more than the project intends to cover, especially regarding the second theorem, but is useful for details absent elsewhere.
- Smith, `Gödel Without (Too Many) Tears`: shortened version of Smith's larger book. Consult this before the larger book, though it may still contain more than the project requires.
- Smullyan, `Diagonalization and Self-Reference`: for understanding diagonalization.
- Wadler, `Proofs are Programs`: for using Lean 4 through the Curry-Howard mindset.
- Weaver, `Truth and Assertibility`: philosophical text on logic with an emphasis on semantics. Not a primary concern of the current endeavor.
- Winterhalter, `Formalisation and Meta-Theory of Type Theory`: detailed account of implementing type theory and logic systems in Coq. Useful for variables, contexts, and substitution in Lean 4.
- Yanofsky, `A Universal Approach to Self-Referential Paradoxes, Incompleteness and Fixed Points`: for understanding diagonalization.

## Lean Source Role

`Logic/Gödel.lean` implements Nagel, Newman, and Hofstadter up to Gödel numbering as outlined in the book.

It implements the PM target language as a Lean DSL using a custom syntax category, and this is the approach to continue.
