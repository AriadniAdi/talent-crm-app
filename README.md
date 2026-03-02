
# 🏷 TalentCRM<img width="1024" height="1024" alt="Ícone de rede com gradiente roxo" src="https://github.com/user-attachments/assets/94f49262-fa19-4986-b923-74d285510a73" />


[![Flutter CI](https://github.com/AriadniAdi/talent-crm-app/actions/workflows/ci.yml/badge.svg)](https://github.com/AriadniAdi/talent-crm-app/actions/workflows/ci.yml)
![Coverage](https://img.shields.io/badge/coverage-95%25-brightgreen)

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
-   ☁ Upload opcional de arquivos de áudio para o Firebase Storage\
-   🧪 Testes unitários para camadas de serviço e controle\
-   ⚙ Integração contínua com análise estática e execução automatizada
    de testes

------------------------------------------------------------------------

## 🛠 Tecnologias Utilizadas

-   Flutter\
-   Dart\
-   GetX\
-   Firebase Storage\
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
