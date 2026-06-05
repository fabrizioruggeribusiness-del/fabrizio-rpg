# Setup — Fabrizio RPG su iPhone + Cloud Sync

Due account gratuiti, ~5 minuti l'uno. Poi Claude finisce il cablaggio.

---

## 1️⃣ GitHub Pages (per averla sull'iPhone)

> ⚠️ Repo **separato**, NON il vault. Qui dentro non ci sono dati clienti, quindi può essere pubblico in sicurezza.

1. Vai su https://github.com/new
2. Nome repo: `fabrizio-rpg` · visibilità: **Public** · NON aggiungere README
3. Crea. Poi nella pagina del repo, copia l'URL SSH (`git@github.com:TUONOME/fabrizio-rpg.git`)
4. Dammi quell'URL: penso io a fare il push del pacchetto già pronto.
5. Dopo il push: repo → **Settings → Pages → Source: main / root → Save**
6. Dopo ~1 min l'app è online su `https://TUONOME.github.io/fabrizio-rpg/`

**Installazione iPhone:** apri quell'URL in Safari → tasto Condividi → *Aggiungi a Home*. Diventa un'app a tutto schermo.

---

## 2️⃣ Supabase (per il sync Mac ↔ iPhone)

1. Vai su https://supabase.com → *Start your project* (login con GitHub)
2. *New project* · nome `fabrizio-rpg` · scegli una password DB (salvala) · region: Frankfurt (EU, per GDPR)
3. Aspetta ~2 min che il progetto si crei
4. **SQL Editor** (icona a sinistra) → incolla tutto il contenuto di `supabase-schema.sql` → **Run**
5. **Project Settings → Data API** (o → API): copiami questi due valori:
   - **Project URL** (es. `https://xxxx.supabase.co`)
   - **anon public key** (la chiave lunga sotto "Project API keys")
6. **Authentication → Providers → Email**: lascia attivo (login via link magico alla tua email)

> 🔒 Sulla chiave: la `anon key` è progettata per stare nel codice del browser — è pubblica per natura, la sicurezza vera la fa la regola RLS dello schema (ognuno vede solo i suoi dati). La chiave **`service_role`** invece è un segreto vero: NON dartela mai a un'app client, NON committarla.

---

## Cosa mi serve da te per chiudere

- [ ] URL SSH del repo GitHub `fabrizio-rpg`
- [ ] Supabase **Project URL**
- [ ] Supabase **anon public key**

Con questi tre, cablo il sync nell'app, testo, e fai il primo login. Fine.
