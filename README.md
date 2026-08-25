# Rogério Tavares 45788 — App Oficial

> Flutter 3.41+ • Supabase • Material 3 • Android / iPhone / Tablette / Web / PWA / Desktop

App e site oficial da campanha de **Rogério Tavares — Deputado Estadual da Bahia — 45788 (Eleições 2026)**.

Recria fielmente os 7 designs do Markdown oficial (Home, Plano de Governo, Central de Notícias,
Agenda Oficial, Transparência e Dados, Fale com Rogério e Gabinete Digital), com painel
administrativo completo (CRUD Master), 16+ telas públicas 100% dinâmicas via Supabase, SEO,
PWA e layout responsivo de 320px a 1920px.

---

## 1. Primeiro acesso — Banco de dados (Supabase)

1. Entre em [supabase.com](https://supabase.com) → projeto `hpubrzclxyhlodtmigrv`.
2. Abra **SQL Editor** e execute, em ordem, o conteúdo destes arquivos (pasta `sql/`):
   `00_extensions` → `01_tables` → `02_rls` → `03_indexes_views` → `04_functions_triggers` → `05_buckets` → `06_seeds`.
3. O seed cria o conteúdo inicial (40 notícias = 4 por categoria, plano de governo, agenda de
   setembro a novembro/2026, cidades, galeria, vídeos, números da transparência) e o **admin padrão**:

   | Campo  | Valor |
   |--------|-------|
   | Email  | `admin@rogeriotavares.com.br` |
   | Senha  | `45788Admin` |

   Troque a senha no painel (Minha Conta) após o primeiro acesso.

> 🔒 RLS pronta: visitante lê tudo, admin/editor/moderador escrevem, mensagens/voluntários/
> demandas são públicas para envio e privadas para leitura. O painel `/admin` é protegido
> por autenticação + verificação de papel.

---

## 2. Rodando o app

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs   # gera modelos Freezed
flutter run -d chrome                                        # Web
flutter build apk --release                                  # Android (APK release)
flutter build web --release                                  # Web para publicar
```

> O APK release sai em `build/app/outputs/flutter-apk/app-release.apk`.

---

## 3. Publicar na Hostinger (site/PWA)

1. Rode `flutter build web --release`.
2. No painel Hostinger (hPanel → Gerenciador de Arquivos), apague o conteúdo de `public_html`.
3. Envie **todo o conteúdo** de `build/web/` para `public_html` (os arquivos `.htaccess`,
   `robots.txt`, `sitemap.xml`, `manifest.json` e `favicon.png` já vêm prontos).
4. No hPanel, garanta que **HTTPS** está ativo (SSL gratuito) e versão do PHP seja irrelevante
   (o site é 100% estático — não usa PHP).

Pronto: o site roda em `https://SEU-DOMINIO.com.br` com rotas limpas (SPA), cache, gzip e PWA instalável.

---

## 4. Quando comprar o domínio — 4 trocas rápidas

| O que | Onde |
|-------|------|
| Domínio (1 lugar, o resto se adapta) | `lib/config/env.dart` → `kSiteDomain` |
| `https://SEU-DOMINIO.com.br` (meta/canonical) | `web/index.html` |
| `SEU-DOMINIO.com.br` | `web/robots.txt` e `web/sitemap.xml` |
| Trocar domínio no banco (SEO do app) | Painel Admin → Conteúdo & Config → Settings `site.domain` |

Depois: **Painel Admin → Redes Sociais** (cadastre Instagram/Facebook/WhatsApp…),
**Contato** (settings `contact`) e **Downloads** (santinho/PDF/logos).

---

## 5. Conteúdo — tudo é dinâmico (Supabase)

| Tela | Origem dos dados |
|------|------------------|
| Home (hero, frases, CTA) | `banner_home` + `settings` |
| Últimas da Campanha / Notícias | `news` + `news_categories` |
| Plano de Governo | `government_plan` + `plan_categories` |
| Agenda + Mapa | `events` + `cities` (+ demandas aprovadas) |
| Galeria / Vídeos | `gallery` / `videos` |
| Fale / Participe / Demandas | `messages` / `volunteers` / `reports` |
| Download, Redes, Transparência | `downloads` / `social_links` / `campaign_numbers` |

O seed usa imagens do próprio design (dimg.dreamflow.cloud) e vídeos placeholder do YouTube
(`dQw4w9WgXcQ`) — substitua pelos conteúdos reais pelo painel.

---

## 6. Estrutura

```
lib/
  admin/        login + dashboard + CRUD genérico + telas especiais (voluntários, mensagens, demandas…)
  models/       Freezed + JsonSerializable (keys snake_case ↔ camelCase)
  pages/        16+ telas públicas + Transparência (frame 5) e Chat (frame 7)
  providers/    Riverpod (supabase, settings, conteúdos)
  repositories/ 1 por domínio (CRUD completo)
  routes/       GoRouter (shell responsivo + drawer + bottom nav + admin)
  services/     Supabase, storage, share, formatos
  theme/        tokens 100% do design (cores, fontes Playfair/Nunito/Space Grotesk, sombras, raios)
  widgets/      componentes do design (chips, cards, badges, chat…)
sql/            migrations prontas na ordem (executar no SQL Editor)
supabase/functions/notify/  Edge Function de push (web/FCM) — deploy opcional
web/            SEO, PWA, .htaccess
```

---

## 7. Notas

- Push web/FCM: credenciais Firebase/VAPID ficam na edge function `supabase/functions/notify`
  (instruções no topo do arquivo). Notificações in-app funcionam sem configuração extra.
- APK release usa o keystore de debug por padrão — para a Play Store, configure assinatura
  release em `android/app/build.gradle.kts`.
- Fontes e ícones são tree-shaken no build, mantendo o app leve.