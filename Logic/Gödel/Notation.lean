import Logic.Gödel.Syntax

set_option autoImplicit false

namespace Gödel
namespace Syntax

declare_syntax_cat pmterm
declare_syntax_cat pmformula

syntax "#" num : pmterm
syntax num : pmterm
syntax:max "s" pmterm : pmterm
syntax pmterm " + " pmterm : pmterm
syntax pmterm " × " pmterm : pmterm
syntax "(" pmterm ")" : pmterm

syntax pmterm " = " pmterm : pmformula
syntax "~" pmformula : pmformula
syntax pmformula " ∨ " pmformula : pmformula
syntax pmformula " ⇒ " pmformula : pmformula
syntax "∃ " pmformula : pmformula
syntax "(" pmformula ")" : pmformula

syntax "term!{" pmterm "}" : term
syntax "form!{" pmformula "}" : term

macro_rules
  | `(term!{#$n:num}) => `(Term.var $n)
  | `(term!{$n:num}) => `(Term.numeral $n)
  | `(term!{s $t:pmterm}) => `(Term.succ term!{$t})
  | `(term!{$t:pmterm + $u:pmterm}) => `(Term.add term!{$t} term!{$u})
  | `(term!{$t:pmterm × $u:pmterm}) => `(Term.mul term!{$t} term!{$u})
  | `(term!{($t:pmterm)}) => `(term!{$t})

macro_rules
  | `(form!{$t:pmterm = $u:pmterm}) => `(Formula.eq term!{$t} term!{$u})
  | `(form!{~$p:pmformula}) => `(Formula.not form!{$p})
  | `(form!{$p:pmformula ∨ $q:pmformula}) => `(Formula.or form!{$p} form!{$q})
  | `(form!{$p:pmformula ⇒ $q:pmformula}) => `(Formula.imp form!{$p} form!{$q})
  | `(form!{∃ $p:pmformula}) => `(Formula.ex form!{$p})
  | `(form!{($p:pmformula)}) => `(form!{$p})

namespace NotationExample

example : term!{3} = Term.numeral 3 := rfl
example : term!{s (#0 + 2)} = Term.succ (Term.add (Term.var 0) (Term.numeral 2)) := rfl
example : form!{∃ (#0 = #1)} = Formula.ex (Formula.eq (Term.var 0) (Term.var 1)) := rfl
example :
    form!{~∃ (#0 = #1)} =
      Formula.not (Formula.ex (Formula.eq (Term.var 0) (Term.var 1))) := rfl

end NotationExample

end Syntax
end Gödel
