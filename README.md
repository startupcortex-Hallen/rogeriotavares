# Rogério Tavares • A Voz do Oeste — Site Oficial

> Flutter Web (PWA) • Supabase • GitHub Actions • GitHub Pages — Deputado Estadual da Bahia • 45788 • Eleições 2026

Site e aplicativo oficial da campanha de **Rogério Tavares (45788)**, candidato a
**Deputado Estadual da Bahia**. Publicado automaticamente no **GitHub Pages** com
**HTTPS**, rotas limpas (sem `#`), PWA instalável e pronto para conexão do domínio
próprio `rogeriotavares.com.br`.

O conteúdo é 100% dinâmico via **Supabase**: notícias, plano de governo (propostas),
agenda, galeria, vídeos, transparência, voluntários, demandas e painel administrativo.

---

## 1. Como funciona a publicação (automática)

**Não existe upload manual.** Toda alteração publicada segue este fluxo:

```
git add .  &&  git commit -m "sua mudança"  &&  git push
        │
        ▼
GitHub Actions (.github/workflows/deploy.yml)
        │
        ▼
1. Instala Flutter 3.x no runner
2. flutter pub get
3. flutter build web --release
4. Publica build/web no GitHub Pages
        │
        ▼
Site no ar em ~3–5 minutos (HTTPS automático)
```

Sempre que um arquivo Flutter for alterado e enviado com `git push` na branch
`main`, o GitHub recompila o site e publica a nova versão sozinho.

---

## 2. Primeiro acesso — Banco de dados (Supabase)

1. Entre em [supabase.com](https://supabase.com) → projeto `hpubrzclxyhlodtmigrv`.
2. Abra **SQL Editor** e execute, em ordem, o conteúdo destes arquivos (pasta `sql/`):
   `00_extensions` → `01_tables` → `02_rls` → `03_indexes_views` → `04_functions_triggers` → `05_buckets` → `06_seeds`.
3. O seed cria o conteúdo inicial (notícias, plano de governo, agenda, cidades,
   galeria, vídeos, números da transparência) e o **admin padrão**:

   | Campo  | Valor |
   |--------|-------|
   | Email  | `admin@rogeriotavares.com.br` |
   | Senha  | `45788Admin` |

   Troque a senha no painel (Minha Conta) após o primeiro acesso.

> 🔒 RLS pronta: visitante lê tudo, admin/editor/moderador escrevem. O painel
> `/admin` é protegido por autenticação + verificação de papel.

---

## 3. Rodando localmente

```bash
flutter config --enable-web        # garante suporte a Web (1x)
flutter pub get
dart run build_runner build --delete-conflicting-outputs   # gera modelos Freezed
flutter run -d chrome                                        # abrir no navegador
```

Build de produção (o mesmo que o GitHub Actions executa):

```bash
flutter build web --release
```

> O site pronto fica em `build/web/`.

---

## 4. Publicar / atualizar o site

```bash
git add .
git commit -m "minha atualização"
git push                        # → dispara o deploy automático
```

Acompanhe em **Repository → Actions → "Deploy Flutter Web — GitHub Pages"**.
Quando o check ficar verde, o site está no ar.

Na primeira publicação, o GitHub Pages precisa estar ativo:

- **Repository → Settings → Pages**
- Source: **GitHub Actions** (o workflow já tenta ativar isso sozinho na 1ª execução)
- O site fica disponível em `https://startupcortex-Hallen.github.io/rogeriotavares/`

### Rotas diretas e atualização de página (sem 404)

O app usa **Path URL Strategy** (URLs sem `#`, ex.: `/noticias`, `/plano/eixos`).
Como o GitHub Pages serve arquivos estáticos, uma rota acessada/atualizada
diretamente responde 404 no servidor — resolvido por:

- `web/404.html` → salva o caminho pedido e recarrega a raiz;
- `lib/utils/web_redirect.dart` → o app lê o caminho salvo e navega para ele.

Resultado: abrir ou atualizar **qualquer URL** funciona perfeitamente
(ex.: `rogeriotavares.com.br/noticias/minha-noticia`).

---

## 5. Conectar o domínio próprio (`rogeriotavares.com.br`)

O arquivo **`CNAME`** (raiz do repositório) já contém `rogeriotavares.com.br`.
Falta apenas apontar o DNS do domínio para o GitHub — feito no painel do seu
registrador (Registro.br, Hostinger, etc.):

| Tipo | Nome | Valor |
|------|------|-------|
| A    | `@` (raiz) | `185.199.108.153` |
| A    | `@` (raiz) | `185.199.109.153` |
| A    | `@` (raiz) | `185.199.110.153` |
| A    | `@` (raiz) | `185.199.111.153` |
| CNAME | `www` | `startupcortex-Hallen.github.io` |

Depois de propagar (alguns minutos a poucas horas):

1. **Settings → Pages → Custom domain** → `rogeriotavares.com.br` → **Save**.
2. Marque **Enforce HTTPS** (certificado automático em minutos).

> ⚠️ Enquanto o DNS não estiver configurado, acesse o site pelo endereço padrão
> `https://startupcortex-Hallen.github.io/rogeriotavares/`. O link direto para o
> domínio só responde depois que os registros DNS acima estiverem ativos.
> O `CNAME` já está no repositório para que nada mais precise ser alterado no código.

Ao ativar o domínio, nenhuma mudança de código é necessária: o site já é servido
na raiz (`--base-href /`).

---

## 6. Conteúdo — tudo é dinâmico (Supabase)

| Tela | Origem dos dados |
|------|------------------|
| Home (hero, frases, CTA) | `banner_home` + `settings` |
| Últimas da Campanha / Notícias | `news` + `news_categories` |
| Plano de Governo (Propostas) | `government_plan` + `plan_categories` |
| Agenda + Mapa | `events` + `cities` (+ demandas aprovadas) |
| Galeria / Vídeos | `gallery` / `videos` |
| Fale / Participe / Demandas | `messages` / `volunteers` / `reports` |
| Download, Redes, Transparência | `downloads` / `social_links` / `campaign_numbers` |

Edite tudo pelo **Painel Admin** (`/admin`) — sem recompilar o site.

---

## 7. Estrutura do repositório

```
.github/workflows/deploy.yml   GitHub Actions: build + publica no GitHub Pages
CNAME                          domínio próprio (rogeriotavares.com.br)
web/
  index.html                   SEO completo (OG, Twitter, JSON-LD, PWA)
  404.html                     fallback SPA → rotas diretas sem 404
  manifest.json + icons/       PWA instalável (tema azul da campanha)
  favicon.png                  favicon
  robots.txt / sitemap.xml     SEO técnico
lib/
  admin/        login + dashboard + CRUD + telas especiais
  models/       Freezed + JsonSerializable
  pages/        telas públicas (Home, Propostas, Agenda, Notícias, Galeria, Contato…)
  providers/    Riverpod (supabase, settings, conteúdos)
  repositories/ 1 por domínio (CRUD completo)
  routes/       GoRouter (path URL strategy, sem #)
  services/     Supabase, storage, share, formatos
  theme/        tokens do design (azul institucional #1565C0)
  widgets/      componentes reutilizáveis
  utils/        web_redirect (deep links no GH Pages)
sql/             migrations prontas (ordem numerada)
supabase/functions/notify/    Edge Function de push (opcional)
```

---

## 8. Performance e PWA

- Build `--release` com tree-shaking do Dart (somente o código usado vai ao ar).
- Imagens com **lazy loading** (`cached_network_image`) e cache em memória/disco.
- **Preconnect/dns-prefetch** para os CDNs de mídia e Supabase no `index.html`.
- PWA instalável: **Adicionar à tela inicial** no Android/iOS (ícones maskables,
  tema `#1565C0`, manifest + shortcuts).
- HTTPS automático (certificado e renovação por conta do GitHub Pages).
- Cache seguro: os assets do Flutter são versionados pelo build, então o
  navegador sempre busca a versão nova ao publicar.

---

## 9. Notas

- Push web/FCM: credenciais Firebase/VAPID na edge function
  `supabase/functions/notify` (instruções no topo do arquivo).
- APK release para a Play Store: configure assinatura em
  `android/app/build.gradle.kts`.
- O `web/.htaccess` existe como fallback para hospedagens Apache tradicionais;
  o GitHub Pages não o utiliza.