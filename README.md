
# 🏷 TalentCRM

<img width="1024" height="1024" alt="Ícone de rede com gradiente roxo" src="https://github.com/user-attachments/assets/94f49262-fa19-4986-b923-74d285510a73" />

<div align="center">
    
![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![GetX](https://img.shields.io/badge/GetX-8C4EB8?style=for-the-badge&logo=getx&logoColor=white)
![Firebase](https://img.shields.io/badge/Firebase-039BE5?style=for-the-badge&logo=Firebase&logoColor=white)

</div>

<div align="center">
    
[![Flutter CI](https://github.com/AriadniAdi/talent-crm-app/actions/workflows/ci.yml/badge.svg)](https://github.com/AriadniAdi/talent-crm-app/actions/workflows/ci.yml)
![Coverage](https://img.shields.io/badge/coverage-95%25-brightgreen)

</div>

O **TalentCRM** é uma aplicação mobile desenvolvida em Flutter que
simula um CRM de Talentos, permitindo explorar profissionais de
diferentes empresas e registrar observações estratégicas associadas a
cada perfil.

A aplicação consome dados da API pública
`https://jsonplaceholder.typicode.com/`, realiza o parse estruturado do
JSON em Models tipados e exibe as informações em Views organizadas
utilizando **GetX** como gerenciador de estado.

------------------------------------------------------------------------

## 📌 Contexto do Produto

O aplicativo simula um cenário onde recrutadores ou gestores podem
visualizar informações públicas de profissionais e registrar avaliações
contextuais por meio de notas de voz, funcionando como um CRM leve para
organização de talentos.

------------------------------------------------------------------------

## 🚀 Funcionalidades

-   🔎 Consumo de API REST pública\
-   🧩 Modelagem e parse de dados JSON\
-   🧠 Gerenciamento de estado com GetX\
-   🔗 Navegação dinâmica com suporte a Deep Linking\
-   🔔 Notificações locais acionadas por eventos da aplicação\
-   🎙 Gravação e reprodução de áudio\
-   🔐 Autenticação de usuários com Firebase Auth\
-   🗂 Persistência básica de usuários com Cloud Firestore\
-   🧪 Testes unitários para camadas de serviço e controle\
-   ⚙ Integração contínua com análise estática e execução automatizada
    de testes

------------------------------------------------------------------------

## 🛠 Tecnologias Utilizadas

-   Flutter\
-   Dart\
-   GetX\
-   Firebase Auth\
-   Cloud Firestore\
-   flutter_local_notifications\
-   Biblioteca de gravação e reprodução de áudio\
-   JSON parsing\
-   GitHub Actions (CI)

------------------------------------------------------------------------

📂 Estrutura de Pastas

O projeto segue arquitetura modular baseada em features.

```
lib/
│
├── core/                         # Recursos compartilhados (utilitários, design, etc)
│
├── features/
│   ├── feature/
│   │   ├── data/                 # Camada de acesso a dados
│   │   ├── domain/               # Entidades e regras de negócio
│   │   ├── presentation/         # Controllers, Views e Bindings
│   │   ├── entities/             # Entidades do domínio
│   │   ├── usecases/             # Casos de uso (regras de negócio)
│   │   ├── model/                # Modelos para serialização
│   │   ├── services/             # Comunicação com API
│   │   └── repositories/         # Implementações de repositórios
│
└── main.dart
```

------------------------------------------------------------------------

## ▶️ Como Executar o Projeto

1.  Clone o repositório:

```{=html}
<!-- -->
```
    git clone https://github.com/seu-usuario/talent-crm.git

2.  Acesse a pasta do projeto:

```{=html}
<!-- -->
```
    cd talent-crm

3.  Instale as dependências:

```{=html}
<!-- -->
```
    flutter pub get

    Para provisionar os arquivos nativos do Firebase em CI, exporte as
    variáveis `GOOGLE_SERVICES_JSON` e/ou `GOOGLE_SERVICE_INFO_PLIST`
    com o conteúdo em base64 e execute:

    ./scripts/setup_firebase.sh

4.  Execute o projeto:

```{=html}
<!-- -->
```
    flutter run

------------------------------------------------------------------------

## 🔗 Como Testar o Deep Link

Após instalar o app no emulador/dispositivo:

### Android

    adb shell am start -a android.intent.action.VIEW -d "talentcrm://talent?id=3"

O aplicativo deve abrir diretamente na tela de detalhes do talento com
ID 3.


### iOS (Simulador)
    xcrun simctl openurl booted "talentcrm://talent?id=3"

O aplicativo deve abrir diretamente na tela de detalhes do talento com ID 3.

------------------------------------------------------------------------

## 🧪 Como Executar os Testes

    flutter test

------------------------------------------------------------------------

## 🔎 Análise Estática

    flutter analyze

O projeto deve executar sem erros críticos.

------------------------------------------------------------------------

## ⚙ Integração Contínua

O projeto possui workflow configurado para:

-   Executar `flutter analyze`\
-   Executar `flutter test`

Garantindo qualidade e validação automática a cada push.
