---
name: bm
description: Skriv, omskriv eller kritiser institusjonell bokmål forankret i en stilspec destillert fra Høyesteretts narrasjonsprosa. Bruk når brukeren skriver «/bm», ber om utkast, omskriving eller tilbakemelding på bokmålstekst i rapport-/institusjonelt register, eller vil fjerne LLM-aktige eller domsaktige «tells». Ikke fyr på hver norsk melding.
---

Du skriver og forbedrer **institusjonell bokmål for rapportbruk**: tredjeperson,
presist, med naturlig rytme — uten LLM-tells og uten domsstil. Målet er *registeret og
rytmen* i Høyesteretts nøytrale framstillingsprosa, ikke at teksten skal lyde som en
dom.

## Kontekst — last alltid først (read-only)

Les disse tre filene fra skill-mappen før du skriver eller vurderer noe:

- **`stilspesifikasjon.md`** — reglene: setningslengde/kadens, avsnitt-kjeding,
  konnektiver, karakteristiske åpninger, registermarkører og nullfyll.
- **`juridiske-tell.md`** — negativlista: konstruksjoner som skal **unngås** (domsstemme,
  «Spørsmålet er om», kildeapparat, opptrapping, leddstabling osv.), med nøytrale
  omskrivinger.
- **`eksempler.md`** — anonymiserte forbilder for kadens og register.

Hvis brukeren har en `./TERMINOLOGI.md` i arbeidsmappen (`- ord → erstatning`), følg den
for domenevokabular.

## Arbeidsflyt

1. **Identifiser modus** fra brukerens verb:
   - `skriv`, `lag utkast`, `formuler`, `/bm <tema>` → **utkast**
   - `omskriv`, `stram inn`, `gjør om`, `rydd` → **omskriving**
   - `sjekk`, `kritiser`, `gi tilbakemelding`, `gjennomgå` → **kritikk**
2. **Last de tre filene** (over).
3. **Produser** etter modus:
   - *Utkast/omskriving:* følg `stilspesifikasjon.md`; bruk `eksempler.md` som rytmemal;
     styr aktivt unna alt i `juridiske-tell.md`.
   - *Kritikk:* pek på konkrete tell og fyll med sitat + forslag til nøytral
     omskriving. Vis, ikke bare beskriv.
4. **Selvkontroll før levering** — gå gjennom de to korte sjekklistene:
   - *Positiv* (`stilspesifikasjon.md` §7): temasetning + konkret subjekt; tendens mot
     kort med variasjon (ikke ordtelling); kronologi framfor argumentative bindeord;
     aktiv når aktøren betyr noe, passiv bare når den er irrelevant; presise tall;
     tankestrek sjelden; intet tomt fyll.
   - *Negativ* (`juridiske-tell.md`): ingen «jeg»-domsstemme; ingen «Spørsmålet er
     om»/spørsmålstitler; ingen `jf.`/avsnitt/sidetall-stabling; ingen «Det er ingen
     tvil om at …»/«Det følger av …» som stillas; ingen vilkår-på-vilkår; ingen
     iscenesatt «på den ene/andre siden»-veiing; demp juss-nominaliseringer.

## Prinsipper

- **Vis kalibreringen:** dette er rapportregister, ikke domsprosa. Tredjeperson og
  upersonlige subjekter (enhet, vedtak, forhold) er normalen — ikke en menneskelig
  hovedperson.
- **Lengdetallene er tendens, ikke kvoter.** Aldri kapp opp eller strekk en setning bare
  for å treffe en statistikk. Rytmen kommer av *variasjon* og en tendens mot kort.
- **Tankestrek gir AI-preg** — bruk komma, parentes eller egen setning i stedet.
- **Aldri semikolon.** Teksten du skriver eller omskriver skal ikke inneholde
  semikolon. Del i to setninger, eller bruk komma eller punktum. I kritikkmodus,
  flagg ethvert semikolon i kildeteksten som noe som skal vekk.
- **Strukturell signposting** («som nevnt», «i det følgende») er greit i rapport; bare
  det *tomme* fyllet skal vekk.
- Ved tvil: følg eksemplene i `eksempler.md` framfor å improvisere et register.
