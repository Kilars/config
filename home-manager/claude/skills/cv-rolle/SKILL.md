---
name: cv-rolle
description: Skriv 2-3 avsnitt prosa om ÉN rolle i ett prosjekt til en konsulent-CV (Bouvet-standard, tredjeperson bokmål). Forventer prosjektbeskrivelse + rollemetadata som input. Avgrenser rollen, foreslår oppdeling i flere roller når det er hensiktsmessig, og kaller `bm` for selve skrivingen. Bruk når brukeren skriver «/cv-rolle» eller vil skrive en rolle/prosjekterfaring til en konsulent-CV.
---

Du skriver **én rolle** til en konsulent-CV: 2-3 avsnitt løpende prosa om hva
konsulenten gjorde i ett prosjekt. Tredjeperson med navn, institusjonell bokmål. Dette
er ikke en generell CV-generator — den produserer prosaen for én avgrenset rolle av
gangen, og forventer at prosjektbeskrivelse og rollemetadata gis som input.

> **Tredjeperson med navn er Bouvets standard for CV-er.** «Ola gikk inn som …», ikke
> «Jeg gikk inn som …». Registeret eies av `bm`-skillen, som denne kaller for selve
> skrivingen.

## Kontekst — last alltid først (read-only)

Les `bouvet-retningslinjer.md` fra skill-mappen før du avgrenser og skriver. Den
destillerer Bouvets offisielle CV-føringer og skiller **harde krav** (compliance —
følges alltid) fra **register** (eies av `bm`). Sentrale harde krav: tredjeperson med
navn, konsulentens egen innsats i forgrunnen, hele setninger, tidsnøytralt, presis
faglig rolletittel, og beskrivelse langs rolle/ansvar/metoder/teknologier/verdi.
Bouvet-standarden vektlegger struktur, innhold og tydelighet — skriv så hva/hvordan/
hvorfor/effekt kommer fram. Det `bm` allerede dekker (avsnittslengde, superlativer,
aktiv stemme) er ikke gjentatt der. Ved konflikt: harde krav vinner, `bm` styrer ordvalg
innenfor dem.

## Hva skillen forventer som input

Prosjektbeskrivelsen står som regel allerede et annet sted i CV-en. **Ikke gjenta
kunde-, marked- eller bakgrunnskontekst i rolleprosaen** — gå rett på hva konsulenten
gjorde. Bruk prosjektbeskrivelsen til å forstå konteksten, ikke til å fylle avsnittene.

Minste sett før du skriver (hybrid: ta fri-form input, sjekk mot dette, grill for det
som mangler):

- **Konsulentens navn** (til tredjeperson).
- **Rolletittel** — eller råmateriale til å foreslå én, se Rolleavgrensning.
- **Ansvar og oppgaver** — hva personen faktisk drev og bidro til.
- **Status/fase** — er arbeidet gjennomført, pågående eller foreslått? (Se Sannhet.)
- **Domene/kontekst** — nok til å forstå hva som var krevende.

Mangler noe av dette, still spørsmål én om gangen i `grill-me`-stil (se den skillen):
spør, gi din anbefaling, gå videre. Ikke skriv før rollen er avgrenset og status er
avklart.

## Arbeidsflyt

0. **Orienter ved behov.** Er input tynt eller brukeren tydelig usikker, gi først én kort
   orientering: at du skriver prosa for *én* rolle, stiller noen få avklaringsspørsmål,
   kan foreslå å dele prosjektet i flere roller, og leverer resultatet i en fil. Har
   brukeren allerede gitt fyldig prosjektbeskrivelse og rollemetadata, hopp over dette og
   gå rett til avgrensning.
1. **Les input.** Forstå prosjektet og det råmaterialet som finnes om rollen. Sjekk mot
   minste sett over.
2. **Avgrens rollen.** Avgjør hva som hører til *denne* rollen. Foreslå oppdeling om
   grunnlaget tilsier det (neste avsnitt).
3. **Avklar status/fase.** Skill mellom gjennomført, pågående og foreslått før du
   skriver. Dette styrer formuleringene.
4. **Velg innhold.** Rollesignal først, få konkrete bevis — ikke oppramsing (se
   Seleksjon).
5. **Skriv via `bm`.** Bygg et kort brief (navn, avgrenset rolle, de utvalgte
   elementene, status-formuleringer) og kall `bm`-skillen for å produsere 2-3 avsnitt i
   riktig register.
6. **Skriv prosaen til en fil.** Lever resultatet som en markdown-fil i arbeidsmappen,
   ikke bare i terminalen — det er klønete å kopiere fra terminalutskrift. Bruk et navn
   som `cv-<rolletittel>.md` (slugifisert, f.eks. `cv-prosessradgiver.md`). Filen
   inneholder rolletittel som overskrift og de 2-3 avsnittene. Oppgi filstien til
   brukeren etterpå.
7. **Oppsummer kort** etter skrivingen: nevn hva du eventuelt holdt ute, og hvorfor
   (f.eks. fordi det hører til en annen rolle). Hold dette i terminalen, ikke i filen.

## Rolleavgrensning og oppdeling

Ett prosjekt rommer ofte flere roller. Når metadataen spenner over tydelig adskilte
kompetansedomener eller faser, **foreslå å dele prosjektet i flere roller** og begrunn
det:

- **Spisser kompetansen.** Én rolle som blander analyse, smidig coaching og KI-arbeid
  blir grøtete. Tre rene roller viser hver kompetanse skarpere.
- **Mer utfyllende innhold.** Hver rolle får plass til egne avsnitt med substans,
  framfor at alt presses inn i én blokk.
- **Faseskille bærer oppdeling.** Innledende analyse og senere implementering er ofte
  to roller — ulikt arbeid, ulik kompetanse, ofte ulik tid.

Foreslå oppdelingen, forklar hvorfor, og la brukeren velge hvilken rolle som skrives nå.
Skriv bare den ene rollen per invokasjon.

## Dybde og vekt på tvers av roller

Denne skillen produserer alltid full 2-3 avsnitt. Det er riktig for rollene som
bærer CV-en — men brukt ukritisk på alle roller gir det en vegg av jevnt trykk
der ingenting skiller seg ut. Leseren har ingen ankerpunkter for hva som faktisk
er viktig.

- **Nyere og relevante roller:** full behandling, 2-3 avsnitt.
- **Eldre eller perifere roller:** ett avsnitt, gjerne kortere.
- **Hvis brukeren allerede har skrevet flere roller og ber om nok en:** spør kort
  hvilken vekt *denne* rollen bør ha relativt til de andre. Juster lengde og
  detaljnivå deretter — ikke kjør samme mal automatisk.

## Seleksjon — ikke oppramsing

Metadataen er råmateriale, ikke en sjekkliste. **Ikke list opp «han gjorde A, B og C».**

- Løft de 2-3 mest differensierende og troverdige detaljene som konkret bevis.
- Abstrahér resten til rolle- og evne-nivå: hva rollen krevde, hva personen drev.
- Kutt det generiske. En detalj som gjelder enhver konsulent, tilfører ingenting.
- La teksten lande på hva personen *kan*, demonstrert gjennom hva som ble gjort — ikke
  en uttømmende logg.

## Sannhet og fase

Innebygd integritetsregel:

- **Avklar alltid status før du skriver.** Hevd aldri resultater som ikke er oppnådd.
- **Pågående eller foreslått arbeid formuleres deretter:** «foreslått», «bidro til»,
  «utarbeidet et forslag til» — ikke «innførte» eller «oppnådde».
- **Skriv aldri en fremtidig rolle som erfaring.** Hører noe til en fase som ennå ikke
  er gjennomført, er det grunnlag for en *senere* rolle, ikke for prosa nå. Si det til
  brukeren.

## Stemme og register

- Tredjeperson med navn (Bouvets standard).
- 2-3 avsnitt, løpende prosa, ingen punktlister i selve teksten.
- Selve registeret (kadens, anti-tells, ordvalg) håndteres av `bm`. Ikke dupliser
  reglene her — kall `bm` med briefet og la den skrive.

## Sjekkliste før levering

1. Én avgrenset rolle, ikke flere blandet sammen.
2. Ingen gjentakelse av prosjektbeskrivelsen — rett på rollen.
3. Status er avklart; intet uoppnådd resultat hevdet.
4. Rollesignal først, få bevis — ingen oppramsing av metadata.
5. Tredjeperson med navn, 2-3 avsnitt, prosa.
6. Prosaen er produsert via `bm`, ikke håndskrevet utenom registeret.
7. Bouvets harde krav er fulgt (`bouvet-retningslinjer.md` §1): egen innsats i
   forgrunnen, hele setninger, tidsnøytralt, presis rolletittel, ingen superlativer.
8. Resultatet er skrevet til en `.md`-fil i arbeidsmappen, og filstien er oppgitt.
