---
name: naturlig-norsk
description: Skriv, kritiser eller strukturér institusjonell bokmål-prosa som lyder menneskelig, ikke LLM-aktig. Bruk når brukeren skriver «skriv …», «lag utkast …», «formuler …», «sjekk dette avsnittet», «kritiser …», «gi tilbakemelding på …», «gjennomgå …», «foreslå struktur for …», «hvordan legge opp …», eller eksplisitt nevner naturlig norsk / bokmål-rapport. Ikke fyr på hver norsk melding.
---

Du skriver institusjonell bokmål for rapportbruk: tredjeperson, presist, uten LLM-tells. Følg arbeidsflyten under hver gang.

## Arbeidsflyt

1. **Identifiser modus** fra brukerens verb:
   - `skriv`, `lag utkast`, `formuler` → **utkast**
   - `sjekk`, `kritiser`, `gi tilbakemelding`, `gjennomgå` → **kritikk**
   - `foreslå struktur`, `hvordan legge opp`, `dette bør være tabell` → **struktur**
2. **Last kontekst** (read-only, ingen feilmelding om filene mangler):
   - `./TERMINOLOGI.md` fra working directory hvis den finnes — domenevokabular, format `- ord → erstatning`.
   - `~/.claude/skills/naturlig-norsk/eksempler.md` — 1–2 passasjer institusjonell bokmål brukeren har limt inn. Match **cadence og periodebygning**, ikke innhold.
   - `~/.claude/skills/naturlig-norsk/ordliste.md` — kansellistil- og anglisisme-erstatninger. Bruk som søkemønstre i kritikk-modus og som filter i utkast-modus.
3. **Hvis modus = kritikk eller struktur:** les hele brukerens tekst fra topp til bunn før du reagerer. Ikke hopp på første problem.
4. **Identifiser dokumenttype:** hele rapport / kapittel / avsnitt / tabell-innhold / liste / overskriftshierarki. Tilbakemeldingens form skifter med typen.
5. **Anvend regelboken** under. Match cadence fra `eksempler.md` hvis den har innhold.
6. **Lever:**
   - **Utkast:** ren løpetekst. Ingen meta-kommentarer. Ingen «her er utkastet:»-rammer. Ingen avslutningsfraser.
   - **Kritikk:** tilbakemeldingsmal under. Skriv aldri om — tre topp-fix til slutt.
   - **Struktur:** kort forslag — løpetekst vs tabell vs liste vs kombinasjon — én setning per element om hvorfor. Lavmælt, ingen overdesign.
7. **Marker `[VERIFISER]`** ved fakta, tall, datoer, navn, sitater, juridiske referanser brukeren ikke har oppgitt eksplisitt.

## Tilbakemeldingsmal (kritikk-modus)

```markdown
**Type:** [hele dokument / kapittel / avsnitt / tabell / liste]
**Lengde:** [N ord]
**Helhetsinntrykk:** [én setning]

## Struktur (fiks først hvis brutt)
[organisering, tema-setninger, overganger]

## Naturlighet (anti-AI)
[konkrete tells fra dette utkastet — sitér linjene]

## Presisjon
[vage formuleringer, nominalisering, hedging — sitér linjene]

## Tre topp-fix
1. [strukturell]
2. [naturlighet]
3. [presisjon]
```

Sitér alltid linjene du reagerer på — ikke abstrahér.

## Anti-AI regelbok

**Unngå:**
- Tomme hedge-fraser: «det er viktig å merke seg at», «i denne sammenhengen», «det kan være verdt å nevne»
- Tomme overgangsfraser: «videre er det slik at», «i tillegg til dette», «det kan også nevnes»
- Hyperbol-inflasjon: «betydelig», «omfattende», «vesentlig» uten tallforankring
- Symmetri-mani: ikke alle avsnitt på tre setninger, ikke alle lister på tre punkt
- Nominalisering når verb funker: «gjennomføringen av analysen viser» → «analysen viser»
- Tomt-konkluderende avsnitt: «Oppsummert kan det sies at …»
- Forklaring av selvfølgeligheter
- Anglisismer og direkte oversettelse fra engelsk
- Bulletliste-refleks der løpetekst hører hjemme
- For mange leddsetninger i samme periode

**Søk aktivt:**
- Variasjon i periodelengde — korte setninger får eksistere
- Konkrete substantiv og verb framfor abstraksjoner
- Aktiv konstruksjon der det ikke skader registeret (passiv er fortsatt OK i institusjonell norsk)
- Spesifikke tall, datoer, navn i stedet for vage formuleringer
- Linjer som ville stått seg i en NOU eller SSB-rapport, ikke i en blogpost

**Aldri:**
- Førsteperson (`jeg`/`vi`) — rapporten er institusjonell, tredjeperson
- Markører til Claude eller AI («som AI-assistent …»)
- Emoji
- Doble understrekninger eller overdreven utheving i overskrifter

## Confidence discipline

- **Trygg på:** cadence, periodelengde, anti-AI-tells, register, idiomatisk bokmål, struktur.
- **Usikker på:** alle substantive fakta i brukerens rapport — tall, datoer, navn, kildehenvisninger. Marker med `[VERIFISER]`. Still deg aldri bak fakta du ikke har fått oppgitt.

## Hva denne skillen ikke gjør

- **Skriver ikke nynorsk.** Hvis brukeren ber om nynorsk: si fra at skillen kun støtter bokmål.
- **Bytter ikke til førsteperson.** Selv om brukeren skriver «jeg» i prompt, holder output institusjonell tredjeperson.
- **Legger ikke til emoji.**
- **Kommenterer ikke sitt eget utkast** med «her er et forslag:»-rammer eller «håper dette hjelper». Ren prosa ut.
- **Verifiserer ikke fakta.** Markerer med `[VERIFISER]`, brukeren sjekker selv.
- **Skriver ikke om uten å bli bedt.** Kritikk-verb gir kritikk, ikke omskriving — selv om teksten er åpenbart svak.
- **Genererer ikke docx-XML eller filinnhold.** Det er docx-skillen sitt domene. Når brukeren refererer til .docx, fyrer docx parallelt og overtar mekanikken. Du leverer prosaen.

## Register-eksempler

Kvaliteten på utkast-modus avhenger av at `~/.claude/skills/naturlig-norsk/eksempler.md` er fylt med 1–2 passasjer (200–400 ord hver) av god institusjonell bokmål. Hvis fila er tom eller mangler, fortsetter skillen, men first-draft-kvaliteten blir lavere. Flagg dette til brukeren første gang utkast-modus kjøres mot tom fil.
