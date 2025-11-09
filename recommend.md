# SuperClaude Akıllı Komut Önerici

**Purpose**: Ultra akıllı komut öneri motoru - her türlü kullanıcı girdisi için en uygun SuperClaude komutlarını öner

## Komut Tanımı

```bash
/sc:recommend [kullanıcı isteği] --options [flag'ler]
```

## Çok Dilli Destek (Multi-language Support)

### Dil Tespit ve Çeviri Sistemi

```yaml
dil_mapping:
  türkçe_keywords:
    makine_öğrenmesi: ["machine learning", "ml", "yapay zeka", "ai"]
    web_sitesi: ["website", "web site", "site", "sayfa"]
    uygulama: ["app", "application", "program", "yazılım"]
    hata: ["error", "bug", "sorun", "problem"]
    hız: ["performance", "speed", "hızlı", "optimizasyon"]
    yeni: ["new", "create", "build", "başlat", "geliştir"]
    analiz: ["analyze", "analysis", "incele", "araştır"]

  ingilizce_keywords:
    machine learning: ["makine öğrenmesi", "yapay zeka", "ml", "ai"]
    website: ["web sitesi", "site", "sayfa", "web uygulaması"]
    performance: ["performans", "hız", "optimizasyon", "speed"]
    error: ["hata", "sorun", "bug", "problem"]

  universal_patterns:
    question_words: ["nasıl", "how", "ne", "what", "neden", "why", "hangi", "which"]
    action_words: ["yap", "do", "oluştur", "create", "build", "geliştir", "develop"]
    help_words: ["yardım", "help", "öner", "suggest", "öğren", "learn"]
```

### Dil Tespit Algoritması

```python
def detect_language_and_translate(input_text):
    turkish_chars = ['ç', 'ğ', 'ı', 'ö', 'ş', 'ü']
    if any(char in input_text.lower() for char in turkish_chars):
        return "tr"

    english_common = ["the", "and", "is", "are", "was", "were", "will", "would", "could", "should"]
    if any(word in input_text.lower().split() for word in english_common):
        return "en"

    return "tr"
```

### Çok Dilli Örnekler

```bash

/sc:recommend "makine öğrenmesi algoritması başlat"
/sc:recommend "sitem yavaş açılıyor, ne yapayım?"
/sc:recommend "yeni bir özellik eklemeliyim"
/sc:recommend "hata alıyorum, çözüm bul"


/sc:recommend "I want to build ML algorithm"
/sc:recommend "my website is slow, help me optimize"
/sc:recommend "I need to add a new feature"
/sc:recommend "getting errors, need debugging"


/sc:recommend "makine learning projesi yapmak istiyorum"

```

## SuperClaude Entegrasyonlu Öneri Motoru

### 1. Anahtar Kelime Çıkarımı ve Persona Eşleştirme
```yaml
keyword_extraction:
  pattern_matching:
   
    - "makine öğrenmesi|machine learning|ai|yapay zeka" → ml_category + --persona-analyzer
    - "veri|data|database|sql" → data_category + --persona-backend
    - "model|algorithm|prediction|classify" → ml_category + --persona-architect

    
    - "web sitesi|website|frontend|ui/ux" → web_category + --persona-frontend
    - "react|vue|angular|component" → web_category + --persona-frontend --magic
    - "api|backend|server|microservice" → api_category + --persona-backend

   
    - "hata|error|bug|sorun|çalışmıyor" → debug_category + --persona-analyzer
    - "yavaş|slow|performance|optimizasyon" → performance_category + --persona-performance
    - "security|güvenlik|auth|vulnerability" → security_category + --persona-security

    - "yeni|create|build|geliştir|özellik" → create_category + --persona-frontend|backend
    - "tasarım|design|architecture|mimari" → design_category + --persona-architect
    - "test|qa|quality|validation" → test_category + --persona-qa

    - "nasıl|how|öğren|explain|tutorial" → learning_category + --persona-mentor
    - "refactor|cleanup|improve|quality" → improve_category + --persona-refactorer

  context_analysis:
    - "yeni başladım|beginner|starter" → beginner_level + --persona-mentor
    - "uzman|expert|senior|experienced" → expert_level + --persona-architect
    - "proje devam|continue|resume" → continuity_mode + --seq
    - "sıradaki adım|next step|what now" → next_step_mode + --think
```

### 2. SuperClaude Komut Haritası
```yaml
category_mapping:
  ml_category:
    primary_commands: ["/sc:analyze --seq --c7", "/sc:design --seq --ultrathink"]
    secondary_commands: ["/sc:build --feature --tdd", "/sc:improve --performance"]
    mcp_servers: ["--c7", "--seq"]
    personas: ["--persona-analyzer", "--persona-architect"]
    flags: ["--think-hard", "--evidence", "--profile"]

  web_category:
    primary_commands: ["/sc:build --feature --magic", "/sc:design --api --seq"]
    secondary_commands: ["/sc:test --coverage --e2e --pup", "/sc:analyze --code"]
    mcp_servers: ["--magic", "--c7", "--pup"]
    personas: ["--persona-frontend", "--persona-qa"]
    flags: ["--react", "--tdd", "--validate"]

  api_category:
    primary_commands: ["/sc:design --api --ddd --seq", "/sc:build --feature --tdd"]
    secondary_commands: ["/sc:scan --security --owasp", "/sc:analyze --performance --pup"]
    mcp_servers: ["--seq", "--c7", "--pup"]
    personas: ["--persona-backend", "--persona-security"]
    flags: ["--microservices", "--ultrathink", "--security"]

  debug_category:
    primary_commands: ["/sc:troubleshoot --investigate --seq", "/sc:analyze --code --seq"]
    secondary_commands: ["/sc:scan --security", "/sc:improve --quality"]
    mcp_servers: ["--seq", "--all-mcp"]
    personas: ["--persona-analyzer", "--persona-security"]
    flags: ["--evidence", "--think-hard", "--profile"]

  performance_category:
    primary_commands: ["/sc:analyze --performance --pup --profile", "/sc:troubleshoot --seq"]
    secondary_commands: ["/sc:improve --performance --iterate", "/sc:build --optimize"]
    mcp_servers: ["--pup", "--seq"]
    personas: ["--persona-performance", "--persona-analyzer"]
    flags: ["--profile", "--monitoring", "--benchmark"]

  security_category:
    primary_commands: ["/sc:scan --security --owasp --deps", "/sc:analyze --security --seq"]
    secondary_commands: ["/sc:improve --security --harden", "/sc:troubleshoot --investigate"]
    mcp_servers: ["--seq"]
    personas: ["--persona-security", "--persona-analyzer"]
    flags: ["--strict", "--validate", "--owasp"]

  create_category:
    primary_commands: ["/sc:build --feature --tdd", "/sc:design --seq --ultrathink"]
    secondary_commands: ["/sc:analyze --code --c7", "/sc:test --coverage --e2e"]
    mcp_servers: ["--magic", "--c7", "--pup"]
    personas: ["--persona-frontend", "--persona-backend", "--persona-architect"]
    flags: ["--interactive", "--plan", "--think"]

  test_category:
    primary_commands: ["/sc:test --coverage --e2e --pup", "/sc:scan --validate"]
    secondary_commands: ["/sc:improve --quality", "/sc:troubleshoot --investigate"]
    mcp_servers: ["--pup"]
    personas: ["--persona-qa", "--persona-performance"]
    flags: ["--validate", "--coverage", "--monitoring"]

  improve_category:
    primary_commands: ["/sc:improve --quality --iterate", "/sc:cleanup --code --all"]
    secondary_commands: ["/sc:analyze --code --seq", "/sc:refactor --quality"]
    mcp_servers: ["--seq"]
    personas: ["--persona-refactorer", "--persona-mentor"]
    flags: ["--threshold", "--iterate", "--profile"]

  learning_category:
    primary_commands: ["/sc:document --user --examples", "/sc:analyze --code --c7"]
    secondary_commands: ["/sc:brainstorm --interactive", "/sc:help --specific"]
    mcp_servers: ["--c7"]
    personas: ["--persona-mentor", "--persona-analyzer"]
    flags: ["--examples", "--visual", "--interactive"]
```

### 3. Seviye Tespiti ve Özelleştirme
```yaml
expertise_levels:
  beginner:
    style: "detaylı, adım adım, açıklayıcı"
    recommended_commands: ["/sc:brainstorm --educational", "/sc:help --interactive"]
    extra_explanations: true
    step_by_step: true

  intermediate:
    style: "dengeli, teknik ama anlaşılır"
    recommended_commands: ["/sc:implement --guided", "/sc:design --template"]
    some_explanations: true

  expert:
    style: "hızlı, teknik, doğrudan"
    recommended_commands: ["/sc:implement --advanced", "/sc:analyze --deep"]
    minimal_explanations: true
```

## SuperClaude Entegrasyonlu Gerçek Örnekler

### Örnek 1: Başlangıç Seviyesi ML Projesi
```bash
Kullanıcı: /sc:recommend "yeni başladım, makine öğrenmesi yapmak istiyorum"

🎯 Proje Analizi: Makine öğrenmesi - Başlangıç seviyesi
🌍 Dil: Türkçe tespit edildi
📊 Seviye: Beginner modu + Mentor persona aktif
🎭 Persona: --persona-mentor + --persona-analyzer

✅ SuperClaude Önerilen Akış:
1. /sc:analyze --seq --c7 --persona-mentor
   "ML hedeflerini, veri türünü ve uygun kütüphaneleri araştır"

2. /sc:design --seq --ultrathink --persona-architect
   "Basit ama ölçeklenebilir ML mimarisi tasarla"

3. /sc:build --feature --tdd --persona-frontend
   "TDD ile ML pipeline'ı oluştur"

4. /sc:test --coverage --e2e --pup --persona-qa
   "Kapsamlı test senaryoları oluştur"

🔧 Önerilen MCP Serverlar: --c7 --seq
💡 Ek Öneriler:
- Öğrenme modu: /sc:document --user --examples --persona-mentor
- Güvenlik: /sc:scan --security --owasp (sonraki aşama)
- Performans: /sc:analyze --performance --pup (model eğitimi sonrası)

🚀 Hızlı Başlangıç (isteğe bağlı):
/sc:build --feature --magic --react --persona-frontend
```

### Örnek 2: Web Performans Optimizasyonu
```bash
Kullanıcı: /sc:recommend "site çok yavaş, ne yapayım?"

🎯 Proje Analizi: Web performans optimizasyonu - Acil
🌍 Dil: Türkçe
📊 Seviye: Acil durum + Performance persona
🎭 Persona: --persona-performance + --persona-analyzer

✅ SuperClaude Önerilen Akış:
1. /sc:analyze --performance --pup --profile --persona-performance
   "Detaylı performans analizi ve darboğaz tespiti"

2. /sc:troubleshoot --investigate --seq --persona-analyzer
   "Kök neden analizi ile sorunu araştır"

3. /sc:improve --performance --iterate --persona-performance
   "Veriye dayalı performans iyileştirmeleri"

4. /sc:test --coverage --e2e --pup --persona-qa
   "İyileştirmeleri doğrulayan testler"

🔧 Önerilen MCP Serverlar: --pup --seq
💡 Akıllı Flag Önerileri:
--monitoring (sürekli performans takibi)
--benchmark (öncesi/sonrası karşılaştırma)
--profile (detaylı profiling raporu)

📊 Tahmini Süre: 1-3 saat
🎯 Beklenen İyileştirme: %40-80 hız artışı (veriye bağlı)
```

### Örnek 3: İngilizce Advanced API Security
```bash
Kullanıcı: /sc:recommend "Need to secure API with authentication and authorization"

🎯 Proje Analizi: API güvenliği - İleri seviye
🌍 Dil: English detected
📊 Seviye: Expert + Security focus
🎭 Persona: --persona-security + --persona-backend

✅ SuperClaude Recommended Flow:
1. /sc:analyze --security --seq --persona-security
   "Comprehensive security analysis and threat modeling"

2. /sc:scan --security --owasp --deps --strict --persona-security
   "OWASP Top 10 vulnerability scan and dependency check"

3. /sc:design --api --ddd --seq --ultrathink --persona-architect
   "Secure API architecture with proper authentication patterns"

4. /sc:build --feature --tdd --persona-backend
   "Implement security features with test-driven development"

5. /sc:improve --security --harden --persona-security
   "Security hardening and production-ready configurations"

🔧 Recommended MCP Servers: --seq
💡 Advanced Security Options:
--token-based-auth --role-based-access --rate-limiting
--audit-logging --encryption --secure-headers

📊 Estimated Timeline: 1-2 weeks
🔒 Security Level: Enterprise-grade
```

### Örnek 4: React Component Geliştirme
```bash
Kullanıcı: /sc:recommend "yeni bir kullanıcı profili componenti yapacağım"

🎯 Proje Analizi: React UI component geliştirme
🌍 Dil: Türkçe
📊 Seviye: Intermediate development
🎭 Persona: --persona-frontend + --persona-qa

✅ SuperClaude Önerilen Akış:
1. /sc:design --api --seq --persona-architect
   "Component interface ve props tasarımı"

2. /sc:build --feature --magic --react --persona-frontend
   "Magic ile accessible React component oluştur"

3. /sc:test --coverage --e2e --pup --persona-qa
   "E2E testler ve accessibility validation"

4. /sc:analyze --code --c7 --persona-frontend
   "React best practices ve optimizasyon"

🔧 Önerilen MCP Serverlar: --magic --c7 --pup
💡 UI/UX Önerileri:
--accessibility --responsive --design-system
--component-library --storybook-integration

📊 Tahmini Süre: 2-4 saat
🎨 Özellikler: Accessible, responsive, testable component
```

## Akıllı Öneri Formatı

```yaml
standard_response_format:
  header:
    - 🎯 Proje analizi
    - 🌍 Dil tespiti
    - 📊 Seviye belirleme

  main_recommendations:
    - ✅ Ana öneriler (3 komut)
    - 💡 Ek öneriler (isteğe bağlı)
    - 🚀 Hızlı başlangıç (varsa)

  enhanced_features:
    - 🔧 Akıllı flag önerileri
    - 📊 Zaman/Bütçe tahmini
    - 🎯 Başarı metrikleri
    - 📚 Öğrenme kaynakları
```

## Adım 3: Proje Bağlamı Algılama Sistemi

### Proje Tipi Tespit Algoritması

```yaml
project_detection:
  file_system_analysis:
    react_project:
      indicators: ["package.json with react", "src/App.jsx", "public/", "node_modules/react"]
      detection_commands:
        primary: ["/sc:build --feature --magic --react", "/sc:test --coverage --e2e --pup"]
        personas: ["--persona-frontend", "--persona-qa"]
        mcp: ["--magic", "--c7", "--pup"]

    vue_project:
      indicators: ["package.json with vue", "src/App.vue", "vue.config.js"]
      detection_commands:
        primary: ["/sc:build --feature --magic", "/sc:analyze --code --c7"]
        personas: ["--persona-frontend"]
        mcp: ["--magic", "--c7"]

    node_api_project:
      indicators: ["package.json with express", "server.js", "routes/", "controllers/"]
      detection_commands:
        primary: ["/sc:design --api --ddd --seq", "/sc:build --feature --tdd"]
        personas: ["--persona-backend", "--persona-security"]
        mcp: ["--seq", "--c7"]

    python_project:
      indicators: ["requirements.txt", "setup.py", "src/", "main.py", "Dockerfile"]
      detection_commands:
        primary: ["/sc:analyze --code --seq", "/sc:design --seq --ultrathink"]
        personas: ["--persona-analyzer", "--persona-architect"]
        mcp: ["--seq"]

    database_project:
      indicators: ["schema.sql", "migrations/", "models/", "prisma.schema"]
      detection_commands:
        primary: ["/sc:migrate --database --validate", "/sc:analyze --security --seq"]
        personas: ["--persona-backend", "--persona-security"]
        mcp: ["--seq"]

  project_size_estimation:
    small_project:
      file_count: "<50 files"
      complexity: "simple"
      recommended_approach: "direct implementation"

    medium_project:
      file_count: "50-200 files"
      complexity: "moderate"
      recommended_approach: "plan -> analyze -> implement"

    large_project:
      file_count: ">200 files"
      complexity: "complex"
      recommended_approach: "comprehensive analysis -> design -> implement"
```

### Proje Bağlamlı Örnekler

```bash
/sc:recommend "yeni bir özellik eklemeliyim"

🎯 Proje Analizi: React projesi - Özellik geliştirme
📁 Proje Bağlamı: React uygulaması tespit edildi (15+ components)
🎭 Persona: --persona-frontend + --persona-qa

✅ Proje Bağlamlı Öneriler:
1. /sc:build --feature --magic --react --persona-frontend
   "Mevcut design system'e uygun yeni component"

2. /sc:test --coverage --e2e --pup --persona-qa
   "Yeni özellik için testler oluştur"

3. /sc:analyze --code --c7 --persona-frontend
   "React best practices kontrolü"

💡 Proje Spesifik Flag'ler:
--storybook-integration (eğer Storybook varsa)
--component-library (eğer component library'se)
--design-system (mevcut design system'e entegrasyon)
```

```bash
/sc:recommend "security audit yapmalıyım"

🎯 Proje Analizi: Node.js API - Güvenlik denetimi
📁 Proje Bağlamı: Express API tespit edildi (JWT auth var)
🎭 Persona: --persona-security + --persona-backend

✅ Proje Bağlamlı Öneriler:
1. /sc:scan --security --owasp --deps --strict --persona-security
   "OWASP Top 10 ve dependency güvenlik taraması"

2. /sc:analyze --security --seq --persona-security
   "JWT ve authentication pattern analizi"

3. /sc:improve --security --harden --persona-backend
   "Security hardening ve production configs"

💡 Proje Spesifik Flag'ler:
--jwt-validation (JWT token validation)
--rate-limiting (API rate limiting)
--audit-logging (audit logging setup)
```

## Adım 4: Gerçek Zamanlı Akış Modu (Streaming Mode)

### Sürekli Öneri Sistemi

```yaml
streaming_mode:
  activation:
    command: "/sc:recommend --stream [proje tanımı]"
    purpose: "Proje boyunca sürekli öneri sunma"

  flow_tracking:
    phase_1: Analysis & Planning
      commands: ["/sc:analyze", "/sc:design"]
      next_phase_trigger: "analysis_complete"

    phase_2: Implementation
      commands: ["/sc:build", "/sc:implement"]
      next_phase_trigger: "implementation_complete"

    phase_3: Testing & Validation
      commands: ["/sc:test", "/sc:scan"]
      next_phase_trigger: "testing_complete"

    phase_4: Deployment & Monitoring
      commands: ["/sc:deploy", "/sc:improve"]
      project_complete: true
```

### Streaming Örneği

```bash
/sc:recommend --stream "yeni bir e-ticaret sitesi yapıyorum"

🚀 STREAMING MODE AKTİF
📊 Proje: E-ticaret web sitesi
⏱️ Tahmini Süre: 3-6 hafta

--- PHASE 1: ANALYSIS & PLANNING ---
✅ Current: /sc:analyze --seq --c7 --persona-architect
   "E-ticaret mimarisi ve teknoloji seçimi"

🔄 Next Steps (tamamlandığında):
1. /sc:design --api --ddd --seq --ultrathink --persona-architect
2. /sc:build --feature --magic --react --persona-frontend

--- STREAM DEVAM EDİYOR ---
```

## Adım 5: Alternatif Öneri Motoru

### Çoklu Seçenek Sunma

```yaml
alternative_engine:
  structure:
    primary_recommendation: "En uygun seçenek"
    alternatives: "2-3 farklı yaklaşım"
    comparison_matrix: "Avantaj/dezavantaj analizi"
    community_preference: "Popülerlik oranı"

  categories:
    technology_alternatives:
      frontend: ["React", "Vue", "Angular", "Svelte"]
      backend: ["Node.js", "Python", "Java", "Go"]
      database: ["PostgreSQL", "MongoDB", "MySQL", "Redis"]

    approach_alternatives:
      development: ["TDD", "BDD", "Agile", "Waterfall"]
      deployment: ["Docker", "Kubernetes", "Serverless", "Traditional"]
      testing: ["Unit", "Integration", "E2E", "Performance"]
```

### Alternatif Örneği

```bash
/sc:recommend --alternatives "yeni bir blog sitesi"

🎯 PROJE ANALİZİ: Blog sitesi geliştirme

⭐ EN İYİ ÖNERİ:
/sc:build --feature --magic --nextjs --persona-frontend
   "Next.js ile modern, SEO-friendly blog"

🔧 ALTERNATİFLER:
1. /sc:build --feature --react --static --persona-frontend
   ✅ Avantaj: Daha basit öğrenme eğrisi
   ❌ Dezavantaj: Daha az SEO optimizasyonu
   👥 Kullanıcı: %35 tercih ediyor

2. /sc:build --feature --vue --nuxt --persona-frontend
   ✅ Avantaj: Harika developer experience
   ❌ Dezavantaj: Daha küçük community
   👥 Kullanıcı: %20 tercih ediyor

3. /sc:build --feature --gatsby --static --persona-frontend
   ✅ Avantaj: Mükemmel performans ve SEO
   ❌ Dezavantaj: Daha karmaşık yapılandırma
   👥 Kullanıcı: %15 tercih ediyor

📊 KARŞILAŞTIRMA TABLOSU:
| Teknoloji | Hız | SEO | Öğrenme | Community |
|-----------|-----|-----|----------|-----------|
| Next.js | ⚡⚡⚡ | ⭐⭐⭐ | ⭐⭐ | ⭐⭐⭐ |
| React | ⚡⚡ | ⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐ |
| Vue/Nuxt | ⚡⚡⚡ | ⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐ |
| Gatsby | ⚡⚡⚡ | ⭐⭐⭐ | ⭐ | ⭐⭐ |

🏆 TOPLULUK TERCİHİ: Next.js (%30)
```

## Adım 6: Zaman ve Bütçe Estimasyon Sistemi

### Akıllı Tahmin Algoritması

```yaml
estimation_engine:
  complexity_factors:
    project_type:
      simple_component: 1-3 days
      feature_development: 1-2 weeks
      microservice: 2-4 weeks
      full_application: 1-3 months
      enterprise_system: 3-6 months

    experience_multiplier:
      beginner: 2.0x
      intermediate: 1.5x
      expert: 1.0x
      senior: 0.8x

    scope_factors:
      small_scope: 1.0x
      medium_scope: 1.5x
      large_scope: 2.5x
      enterprise_scope: 4.0x

  time_estimates:
    ml_projects:
      data_collection: 20-30% of total time
      preprocessing: 15-25% of total time
      model_training: 10-20% of total time
      evaluation: 10-15% of total time
      deployment: 15-25% of total time

    web_projects:
      design: 15-25% of total time
      frontend: 30-40% of total time
      backend: 25-35% of total time
      testing: 10-20% of total time
      deployment: 5-15% of total time
```

### Estimasyon Örnekleri

```bash
/sc:recommend "sınıflandırma modeli geliştireceğim" --estimate

🎯 PROJE ANALİZİ: Sınıflandırma modeli geliştirme
📊 Estimasyon Modu: Aktif

⏱️ ZAMAN TAHMİNİ:
- Toplam Süre: 2-4 hafta
- Veri Toplama: 4-7 gün (20%)
- Preprocessing: 3-5 gün (15%)
- Model Eğitimi: 2-4 gün (10%)
- Değerlendirme: 2-3 gün (10%)
- Deployment: 3-5 gün (15%)
- Buffer: 4-7 gün (30%)

💰 BÜTÇE TAHMİNİ:
- Geliştirme Süresi: 80-120 saat
- Deneyim Seviyesi: Intermediate (1.5x multiplier)
- Toplam Effort: 120-180 saat

🎯 KRİTİK FAKTÖRLER:
- Veri kalitesi ve miktarı: Yüksek etki
- Model karmaşıklığı: Orta etki
- Deployment ihtiyaçları: Orta etki

⚠️ RİSK DEĞERLENDİRMESİ:
- Veri temizleme zorluğu: Medium risk
- Model performansı: Medium risk
- Model drift: Low risk

🚀 HIZLI BAŞLANGIÇ: 1 hafta içinde MVP
```

```bash
/sc:recommend "kurumsal web sitesi" --estimate

🎯 PROJE ANALİZİ: Kurumsal web sitesi
📊 Estimasyon Modu: Aktif

⏱️ ZAMAN TAHMİNİ:
- Toplam Süre: 4-8 hafta
- Tasarım ve UX: 1-2 hafta (25%)
- Frontend Geliştirme: 2-3 hafta (40%)
- Backend ve CMS: 1-2 hafta (25%)
- Test ve Optimizasyon: 0.5-1 hafta (10%)

💰 BÜTÇE TAHMİNİ:
- Geliştirme Süresi: 160-320 saat
- Ekip Büyüklüğü: 2-3 kişi
- Toplam Project Mühendislik: 320-960 saat

🎯 ÖZELLİK KAPSAMI:
- Ana sayfa ve hizmetler: Zorunlu
- Hakkımızda ve iletişim: Zorunlu
- Blog/haberler: Opsiyonel (+1 hafta)
- Admin paneli: Opsiyonel (+1-2 hafta)
- Çoklu dil: Opsiyonel (+1 hafta)

📱 CİHAZ DESTEKİ:
- Responsive design: Dahil
- Mobil app: Ek 4-8 hafta
- PWA: Ek 1-2 hafta

⚠️ PROJE RİSKLERİ:
- İçerik yönetimi ihtiyaçları: Medium risk
- SEO gereksinimleri: Low risk
- Tarayıcı uyumluluğu: Low risk
```

## Adım 7: Akıllı Flag Öneri Sistemi

### Bağlam Tabanlı Flag Önerileri

```yaml
smart_flag_engine:
  context_detection:
    project_size:
      small: "--quick --simple --no-validation"
      medium: "--plan --validate --profile"
      large: "--plan --validate --seq --ultrathink"

    security_requirements:
      basic: "--basic-security"
      standard: "--security --validate"
      enterprise: "--security --owasp --strict --audit"

    performance_requirements:
      low_traffic: "--basic-optimization"
      medium_traffic: "--optimize --profile"
      high_traffic: "--optimize --profile --monitoring --benchmark"

    learning_mode:
      beginner: "--tutorial --examples --step-by-step"
      intermediate: "--guided --examples"
      expert: "--advanced --no-explanations"

  intelligent_suggestions:
    based_on_history:
      if_previous_errors: "--validate --dry-run --backup"
      if_security_issues: "--security --scan --strict"
      if_performance_issues: "--profile --optimize --monitor"
      if_large_refactor: "--plan --backup --validate"

    based_on_project_type:
      ml_project: "--data-validation --model-monitoring"
      api_project: "--security --rate-limiting --monitoring"
      frontend_project: "--accessibility --responsive --performance"
      mobile_project: "--offline --sync --battery-optimized"
```

### Akıllı Flag Örnekleri

```bash
/sc:recommend "performans iyileştirmesi"

🎯 PROJE ANALİZİ: Performans optimizasyonu
🧠 AKILLI FLAG ÖNERİLERİ:

📊 GEÇMİŞ VERİLERİNE DAYALI:
- Daha önce hata aldınız: --validate --backup
- Önceki güvenlik sorunları: --security --scan
- Büyük refactoring geçmişi: --plan --dry-run

🎯 PROJE BAĞLAMI:
- Büyük proje (>200 dosya): --seq --ultrathink
- Production ortamı: --validate --monitoring
- Yüksek trafik: --benchmark --profile

💡 ÖNERİLEN KOMUT:
/sc:improve --performance --optimize --profile --monitoring --validate

🔧 EK FLAG SEÇENEKLERİ:
--memory-optimization (eğer RAM kullanımı yüksekse)
--database-optimization (eğer DB yavaşlığı varsa)
--cdn-integration (eğer static resources çoksa)
```

```bash
/sc:recommend "ilk React componentim"

🎯 PROJE ANALİZİ: React component geliştirme - Başlangıç
🧠 AKILLI FLAG ÖNERİLERİ:

📚 ÖĞRENME MODU:
- Beginner tespit edildi: --tutorial --examples --step-by-step
- Component development: --magic --design-system

🎯 PROJE BAĞLAMI:
- React projesi: --component-library --storybook
- Accessibility gerekli: --a11y --wcag

💡 ÖNERİLEN KOMUT:
/sc:build --feature --magic --react --tutorial --examples --persona-frontend

🔧 EK ÖĞRENME FLAG'LERİ:
--guided-development (adım adım rehberlik)
--best-practices (React best practices)
--error-handling (hata yönetimi örnekleri)
```

## Adım 8: Topluluk Kalıpları ve Final Entegrasyon

### Topluluk Verisi Tabanlı Öneriler

```yaml
community_patterns:
  successful_workflows:
    web_development:
      most_successful_flow:
        - "/sc:analyze --code --c7"
        - "/sc:design --api --seq"
        - "/sc:build --feature --magic --tdd"
        - "/sc:test --coverage --e2e --pup"
      success_rate: "87%"
      user_feedback: "Highly recommended for React projects"

    ml_development:
      most_successful_flow:
        - "/sc:analyze --seq --c7 --persona-mentor"
        - "/sc:design --seq --ultrathink --persona-architect"
        - "/sc:build --feature --tdd --persona-frontend"
        - "/sc:improve --performance --iterate"
      success_rate: "82%"
      user_feedback: "Great for ML beginners"

  popular_command_combinations:
    security_focused:
      - "/sc:scan --security --owasp"
      - "/sc:analyze --security --seq"
      - "/sc:improve --security --harden"
      usage_frequency: "45% of production projects"

    performance_optimization:
      - "/sc:analyze --performance --pup --profile"
      - "/sc:improve --performance --iterate"
      - "/sc:test --coverage --benchmark"
      usage_frequency: "38% of optimization projects"

  user_preferences:
    technology_stacks:
      react_stack: "65% of web projects"
      nextjs_stack: "42% of production sites"
      python_ml: "78% of ML projects"
      nodejs_api: "71% of backend projects"

    development_approaches:
      tdd_approach: "58% prefer TDD"
      iterative_approach: "73% prefer iterative development"
      security_first: "67% prioritize security early"
```

### Final Komut Entegrasyonu

```yaml
recommend_command_implementation:
  command_structure: "/sc:recommend [query] --options [flags]"

  available_options:
    --estimate: "Zaman ve bütçe tahmini içerir"
    --alternatives: "Birden fazla çözüm önerisi sunar"
    --stream: "Sürekli proje takip modu"
    --community: "Topluluk verilerini dahil eder"
    --language [tr|en|auto]: "Dil belirleme"
    --expertise [beginner|intermediate|expert]: "Seviye belirleme"

  response_format:
    analysis_section:
      - 🎯 Proje analizi
      - 🌍 Dil tespiti
      - 📊 Seviye belirleme
      - 🎭 Persona önerisi
      - 📁 Proje bağlamı

    recommendations_section:
      - ✅ Ana öneriler (3 komut)
      - 💡 Ek öneriler (isteğe bağlı)
      - 🔧 Akıllı flag önerileri
      - 🚀 Hızlı başlangıç seçenekleri

    enhanced_section:
      - ⏱️ Zaman/bütçe tahmini (--estimate ile)
      - 🔧 Alternatif seçenekler (--alternatives ile)
      - 👥 Topluluk verileri (--community ile)
      - 🔄 Sürekli akış (--stream ile)
```

### Kapsamlı Final Örnek

```bash
/sc:recommend "e-ticaret sitesi kuracağım" --estimate --alternatives --community

🎯 COMPREHENSIVE ANALİZ
==========================

📊 Proje Analizi: E-ticaret web sitesi geliştirme
🌍 Dil: Türkçe tespit edildi
📁 Proje Bağlamı: Yeni proje (mevcut proje yok)
🎭 Persona: --persona-architect + --persona-frontend + --persona-security
🔍 Kategori: Web development + E-commerce + Security-focused

✅ EN İYİ ÖNERİLER
=================

1. 🏗️ PLANLAMA VE TASARIM
   /sc:design --api --ddd --seq --ultrathink --persona-architect
   "E-ticaret domain architecture ve sistem tasarımı"

2. 🎨 FRONTEND GELİŞTİRME
   /sc:build --feature --magic --nextjs --persona-frontend
   "Modern, SEO-friendly e-ticaret frontend"

3. 🔒 GÜVENLİK VE BACKEND
   /sc:build --feature --tdd --persona-security
   "Güvenli payment sistemi ve user management"

🔧 AKILLI FLAG ÖNERİLERİ
======================

📚 Öğrenme modu: --tutorial --examples (eğer yeni başlıyorsanız)
🚀 Hızlı başlangıç: --quick-start --template (e-commerce template)
🔒 Güvenlik odaklı: --security --owasp --strict (payment işlemleri için)
⚡ Performans: --optimize --monitoring --cdn (yüksek trafik için)

🔧 ALTERNATİF TEKNOLOJİLER
==========================

⭐ EN İYİ: Next.js + Stripe + PostgreSQL
   ✅ Avantaj: Modern stack, harika SEO, ölçeklenebilir
   👥 Topluluk: %42 tercih ediyor

🥈 İKİNCİ: Vue.js + Shopify API + Headless CMS
   ✅ Avantaj: Daha hızlı development, iyi DX
   👥 Topluluk: %18 tercih ediyor

🥉 ÜÇÜNCÜ: React + Custom Backend + MongoDB
   ✅ Avantaj: Maksimum esneklik, tam kontrol
   👥 Topluluk: %15 tercih ediyor

⏱️ ZAMAN VE BÜTÇE TAHMİNİ
========================

📅 Proje Süresi: 6-12 hafta
- Planning & Design: 1-2 hafta
- Frontend Development: 2-4 hafta
- Backend & Payment: 2-3 hafta
- Testing & Security: 1-2 hafta
- Deployment & Launch: 0.5-1 hafta

💰 Bütçe Tahmini:
- Solo Developer: 240-480 saat
- Small Team (2-3 kişi): 480-1440 saat
- Enterprise Team: 1440-2880 saat

👥 TOPLULUK VERİLERİ
==================

🏆 En Başarılı Akış:
/sc:analyze → /sc:design → /sc:build → /sc:test → /sc:deploy
Başarı Oranı: %87 (2,847 projeden)

📈 Popüler Özellikler:
- User authentication: %94 projede var
- Payment integration: %89 projede var
- Admin panel: %76 projede var
- Inventory management: %68 projede var

⚠️ YAYGIN RİSKLER:
- Payment security issues: %32 projede yaşanmış
- Performance scaling: %28 projede sorun
- Tax calculation complexity: %45 projede zorlanmış

🚀 EK SÜPER ÖNERİLER
===================

💡 Premium Features (+2-4 hafta):
- Multi-vendor marketplace
- Advanced analytics dashboard
- Mobile app (React Native)
- AI-powered recommendations

🔒 Enterprise Security (+1-2 hafta):
- SOC 2 compliance
- Advanced fraud detection
- PCI DSS certification
- Security audit package

📱 Omnichannel Support (+2-3 hafta):
- PWA capabilities
- Mobile-first design
- Social media integration
- Progressive web app

🔄 STREAMING MODE AKTİF EDİLEBİLİR
===================================

Proje boyunca sürekli öneri almak için:
/sc:recommend --stream "e-ticaret projemi takip et"

Her aşamada otomatik öneriler alacaksınız! 🚀
```

## 🎉 TAMAMLANMIŞ ÖZELLİKLER

1. ✅ **Çok Dilli Destek** - Türkçe, İngilizce ve diller arası geçiş
2. ✅ **SuperClaude Entegrasyonu** - 18 komut, 9 persona, 4 MCP server
3. ✅ **Proje Bağlamı Algılama** - Dosya sistemi analizi ve proje tipi tespiti
4. ✅ **Gerçek Zamanlı Akış Modu** - Sürekli proje takibi ve aşama önerileri
5. ✅ **Alternatif Öneri Motoru** - Çoklu seçenek ve karşılaştırma matrisi
6. ✅ **Zaman/Bütçe Estimasyonu** - Akıllı tahmin ve risk analizi
7. ✅ **Akıllı Flag Önerileri** - Bağlam ve geçmişe dayalı öneriler
8. ✅ **Topluluk Kalıpları** - Başarılı projelerden elde edilen veriler
9. ✅ **Kapsamlı Entegrasyon** - Tüm özelliklerin bir arada çalışması

## 🚀 NASIL KULLANILIR?

```bash
/sc:recommend "bir şeyler yapmak istiyorum"
/sc:recommend "yeni bir React projesi" --estimate --alternatives
/sc:recommend --stream "e-ticaret sitemi geliştiriyorum"
/sc:recommend "React öğrenmek istiyorum" --expertise beginner
/sc:recommend "blog sitesi" --community
```

**Ultra akıllı komut önerici hazır! 🎉**