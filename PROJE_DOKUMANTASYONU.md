# Claude Docker Proje Dokümantasyonu

## 📋 Proje Bakış

Bu proje, Claude Code CLI ve SuperClaude framework'ünü birleştiren, Türkçe arayüze sahip Dockerize edilmiş bir geliştirme ortamıdır. Otomatik güncelleme yönetimi ve çok katmanlı yapılandırma sistemi sunar.

## 🏗️ Sistem Mimarisi

### Konteyner Yapısı
- **Temel Image**: Ubuntu 22.04 üzerinde Node.js 22.x, Python 3 ve Git
- **Çekirdek Entegrasyon**: Claude Code CLI ile SuperClaude framework entegrasyonu
- **Güncelleme Sistemi**: Otomatik sürüm kontrolü ve isteğe bağlı güncellemeler
- **Yerelleştirme**: Türkçe arayüz ve mesajlaşma sistemi

### Ana Bileşenler
- **Dockerfile**: Claude Code, SuperClaude ve bağımlılıkları kuran çok aşamalı yapı
- **docker-compose.yml**: Servis konfigürasyonu ve volume yönetimi
- **Güncelleme Scriptleri**: Otomatik sürüm yönetimi (`check_update.sh`, `update_now.sh`)
- **Başlangıç Entegrasyonu**: Konteyner başlangıcında otomatik güncelleme kontrolü

## 📁 Proje Yapısı

```
claude-docker/
├── 🐳 Dockerfile              # Konteyner build spesifikasyonu
├── 🚀 docker-compose.yml      # Servis orkestrasyonu
├── 🔧 .env                    # Ortam değişkenleri
├── ⚡ startup.sh              # Konteyner başlatma ve SuperClaude kurulumu
├── 🔄 check_update.sh         # Sürüm takibi ve güncelleme yönetimi
├── 📦 update_now.sh           # Güncelleme çalıştırma mantığı
└── 📚 CLAUDE.md               # Proje dokümantasyonu
```

## 🔧 Ortam Yapılandırması

### Gerekli Ortam Değişkenleri (.env dosyası)
```bash
ANTHROPIC_BASE_URL=https://api.z.ai/api/anthropic    # Özel API endpoint
ANTHROPIC_AUTH_TOKEN=your_token_here                 # Kimlik doğrulama anahtarı
CLAUDE_CODE_SKIP_AUTH_LOGIN=1                        # Otomatik giriş
ANTHROPIC_DEFAULT_SONNET_MODEL=glm-4.6              # Model eşleştirmesi
ANTHROPIC_DEFAULT_OPUS_MODEL=glm-4.6
ANTHROPIC_DEFAULT_HAIKU_MODEL=glm-4.5-air
LOCAL_PATH=/Users/baran                             # Host sistem yolu
```

### Konteyner Ortamı
- `CLAUDE_HOME=/root/.claude` - Claude konfigürasyon dizini
- `CLAUDE_DISABLE_PLUGINS=true` - Eklenti yönetimi
- `SUPERCLAUDE_PATH=/opt/SuperClaude_Framework` - Framework yolu
- Çalışma dizini: `/workspace`

## 🚀 Kullanım Komutları

### Geliştirme Ortamı
```bash
# Konteyneri build et ve başlat
docker-compose up -d --build

# Çalışan konteynere eriş
docker-compose exec claude bash

# Konteyner loglarını görüntüle
docker-compose logs -f claude

# Konteyneri durdur
docker-compose down
```

### Güncelleme Yönetimi
```bash
# Manuel güncelleme kontrolü (konteyner içinde)
/usr/local/bin/check_update.sh

# Zorla güncelleme (konteyner içinde)
/usr/local/bin/update_now.sh

# Güncelleme kontrolünü atla ve Claude'u başlat
docker-compose exec claude bash -c "claude"
```

### SuperClaude Framework
```bash
# SuperClaude komutlarına eriş (konteyner içinde)
sc help
sc install --force --yes
sc update
```

## 🔄 Volume Mounting Stratejisi

Proje, kalıcılık ve izolasyon için stratejik volume mounting kullanır:
- **Ana workspace**: `${LOCAL_PATH}:/workspace` - Host dizinini workspace olarak mount eder
- **Claude izolasyonu**: `${LOCAL_PATH}/empty:/workspace/.claude` - Claude konfigürasyonunu izole eder

## ⬆️ Güncelleme Sistemi Mimarisi

### Otomatik Güncelleme Akışı
1. Konteyner başlangıcı `check_update.sh` tetikler (.bashrc üzerinden)
2. Script kurulu vs en son SuperClaude sürümünü karşılaştırır
3. Güncelleme kararları için etkileşimli prompt (auto-start modunda değilse)
4. İsteğe bağlı güncelleme `update_now.sh` üzerinden çalıştırılır
5. Güncelleme işleminden sonra otomatik Claude Code başlatma

### Sürüm Yönetimi
- En son sürüm tespiti için `pip index versions` kullanılır
- `sort -V` ile anlamsal sürüm karşılaştırması
- Renk kodlu çıktı ve Türkçe yerelleştirme
- Sorun giderme için log desteği

## 🔗 Entegrasyon Noktaları

### Claude Code CLI Entegrasyonu
- **Kurulum Yöntemi**: `curl -fsSL https://claude.ai/install.sh` üzerinden doğrudan kurulum
- **Çalışma Zamanı Entegrasyonu**: Güncelleme işleminden sonra otomatik başlatma
- **Etkileşimli Shell**: `script -q -c "claude"` üzerinden erişim

### SuperClaude Framework Bağlantısı
- **Framework Kurulumu**: `pip install SuperClaude` üzerinden Python paketi kurulumu
- **Otomatik Konfigürasyon**: Expect script'leri ile kurulum
- **Eklenti Sistemi**: Sembolik linking ile entegrasyon

### Harici API Bağımlılıkları
- **Anthropic API Entegrasyonu**: Özel API endpoint konfigürasyonu
- **Kimlik Doğrulama**: Token yönetimi ve otomatik giriş
- **Model Eşleştirme**: GLM modellerini Anthropic modelleri ile eşleştirme

## 🛡️ Güvenlik Hususları

### Kimlik Doğrulama Yönetimi
- Kimlik doğrulama tokenları ortam değişkenlerinde saklanır
- Claude konfigürasyonu ayrı volume mount ile izole edilir
- Otomatik kurulum için expect script'leri kullanılır

### İzolasyon Stratejileri
- Claude konfigürasyonu host sistemden izole edilir
- Çalışma alanı kalıcılığı için volume mount kullanılır
- Güvenlik için eklenti yönetimi devre dışı bırakılır

## 🎨 Yerelleştirme

Tüm kullanıcıya yönelik mesajlar Türkçe dilinde ve renk kodlamalıdır:
- 🟡 Sarı - Uyarılar ve promptlar
- 🔵 Mavi - Bilgilendirici mesajlar
- 🟢 Yeşil - Başarı durumları
- 🔴 Kırmızı - Hatalar ve kritik bildirimler

## 📊 Teknik İlişkiler ve Veri Akışları

### Build Pipeline Akışı
```
Ubuntu 22.04 Temel → Sistem Paketleri → Node.js 22.x →
Claude Code CLI → SuperClaude Framework → Konfigürasyon Kurulumu →
Script Kurulumu → Çalışma Zamanı Ortamı
```

### Çalışma Zamanı Veri Akışı
```
Konteyner Başlat → Ortam Yükle → Güncelleme Kontrolü →
(İsteğe Bağlı) Güncelleme Çalıştır → Claude Code Başlat →
Etkileşimli Oturum → Workspace Erişimi
```

### Güncelleme Veri Akışı
```
Sürüm Sorgu → PyPI API → Sürüm Ayrıştır → Karşılaştır →
Kullanıcı Kararı → Paket İndir → Kurulum →
Framework Güncelle → Konfigürasyon Yenile → Claude Yeniden Başlat
```

## 🔍 Mimarik Desenleri

### **Konteynerizasyon Deseni**
- Claude Code geliştirmesine odaklanmış tek sorumluluklu konteyner
- Esas bağımlılıklar ile minimal temel image
- Hata dayanıklılığı ile otomatik build süreci

### **Güncelleme Yönetimi Deseni**
- Otomatik tespit ile anlamsal sürümlendirme
- Etkileşimli ve otomatik güncelleme modları
- Zarif degradation ve hata yönetimi

### **Yapılandırma Yönetimi Deseni**
- Çok katmanlı ortam tabanlı yapılandırma
- İzolasyon stratejisi ile volume tabanlı kalıcılık
- Eklenti yönetimi ile güvenlik bilinçli tasarım

### **Entegrasyon Deseni**
- Çoklu framework entegrasyonu (Claude Code + SuperClaude)
- Özel endpoint desteği ile API soyutlama
- Insan-in-the-loop seçenekleri ile otomatik iş akışı

Bu mimari, Claude Code ve SuperClaude framework arasında kusursuz entegrasyon sağlayan, otomasyon, güvenlik ve kullanıcı deneyimini dengeleyen sofistike bir Docker tabanlı geliştirme ortamı göstermektedir.