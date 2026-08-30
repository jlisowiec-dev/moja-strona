# Strona Kancelarii Podatkowo-Księgowo-Restrukturyzacyjnej Lisowiec

Statyczna strona (HTML + CSS + jeden plik JS), bez frameworków i bez procesu budowania.
Można ją otworzyć lokalnie (podwójny klik w `index.html`) lub wrzucić na dowolny hosting.

## Struktura

| Plik | Zakładka |
|------|----------|
| `index.html` | Strona główna |
| `o-kancelarii.html` | O kancelarii |
| `uslugi.html` | Usługi (6 obszarów, każdy z kotwicą `#...`) |
| `zespol.html` | Zespół + karta r.pr. Patrycji Szatkowskiej |
| `baza-wiedzy.html` | Materiały dydaktyczne: artykuły, pliki do pobrania, newsletter, FAQ |
| `kontakt.html` | Kontakt kancelarii + osobna sekcja kontaktowa r.pr. Patrycji Szatkowskiej (`#patrycja-szatkowska`) |
| `polityka-prywatnosci.html` | Szkielet polityki prywatności / cookies (do uzupełnienia) |
| `assets/style.css` | Cała stylistyka + paleta kolorów (zmienne CSS na górze pliku) |
| `assets/script.js` | Menu mobilne, filtr bazy wiedzy, obsługa formularzy (demo), rok w stopce |

## Kolory (wg logo — złoto/czerń)

Zdefiniowane jako zmienne CSS w `:root` w `assets/style.css`:
`--gold-50 … --gold-900`, `--ink`, `--paper`, gradient `--gold-gradient`.
Zmiana jednej wartości aktualizuje całą stronę.

Fonty: **Cinzel** (logotyp/nagłówki wielkie litery — zbliżony do logo), **Cormorant Garamond**
(nagłówki), **Inter** (tekst). Ładowane z Google Fonts.

## Co trzeba uzupełnić przed publikacją

Wszystkie miejsca w nawiasach kwadratowych `[ ... ]`, w szczególności:

- pełna nazwa i forma prawna podmiotu, adres, NIP, REGON, nr wpisu (doradca podatkowy / KRS / OIRP), nr rachunku
- prawdziwy telefon i adresy e-mail (obecnie placeholdery `[+48 000 000 000]`, adresy w domenie `kancelaria-lisowiec.pl`)
- imiona, nazwiska, tytuły zawodowe i numery wpisów członków zespołu + zdjęcia
- **r.pr. Patrycja Szatkowska** — potwierdzić adres e-mail (`p.szatkowska@kancelaria-lisowiec.pl`), telefon, OIRP i nr wpisu
- treść artykułów w bazie wiedzy + pliki PDF/DOCX do pobrania
- kod mapy (`<iframe>`) na stronie kontaktu
- treść polityki prywatności i informacja o cookies (najlepiej weryfikacja przez r.pr. Szatkowską)

## Logo i wygląd wizytówki

W nagłówku i stopce każdej strony użyto oryginalnego pliku `assets/logo.png`
(kopia `logo_kancelaria_lisowiec przycięte.PNG` z pulpitu). Nagłówek ma złote,
metaliczne tło zgodne z wizytówką, dzięki czemu wtopione w logo złoto jest
niewidoczne. Krój napisów (nagłówki, logotyp) to **Cinzel** — wolny odpowiednik
kroju z logo. Aby wymienić logo, podmień `assets/logo.png` (proporcje ok. 1024×527).

## Formularze

Formularz kontaktowy i zapis do newslettera mają `data-demo` — nie wysyłają danych,
pokazują tylko komunikat. Aby działały, podłącz usługę formularzy (np. Formspree,
własny endpoint) i usuń atrybut `data-demo` lub zmień obsługę w `assets/script.js`.

## Uruchomienie lokalnego podglądu (opcjonalnie)

```bash
npx serve "C:/Users/Admin/Desktop/strona kpk"
```
