{
  "name": "My workflow",
  "nodes": [
    {
      "parameters": {
        "updates": [
          "message"
        ],
        "additionalFields": {}
      },
      "type": "n8n-nodes-base.telegramTrigger",
      "typeVersion": 1.5,
      "position": [
        0,
        0
      ],
      "id": "63936434-7d88-4927-b7d0-3d00a4368f3c",
      "name": "Telegram Trigger",
      "webhookId": "cded03ec-c559-4ce6-9b13-22f7a6aa4c46",
      "credentials": {
        "telegramApi": {
          "id": "9a9khWbBWIX0H3bA",
          "name": "Telegram account"
        }
      }
    },
    {
      "parameters": {
        "jsCode": "const text = $json.message.text;\nconst parts = text.split(' ');\n\nconst category = parts[0];\nconst amount = parseFloat(parts[1]);\nconst description = parts.slice(2).join(' ');\n\nreturn [{\n  json: {\n    category: category,\n    amount: amount,\n    description: description,\n    date: new Date().toISOString()\n  }\n}];"
      },
      "type": "n8n-nodes-base.code",
      "typeVersion": 2,
      "position": [
        160,
        0
      ],
      "id": "326a0c9f-81d6-4887-b502-0d44ebdae248",
      "name": "Code in JavaScript"
    },
    {
      "parameters": {
        "operation": "append",
        "documentId": {
          "__rl": true,
          "value": "1OMETcHXyTC9nXsYGxIrF6vY5zvgX1j0oyJu8aSeXtGs",
          "mode": "list",
          "cachedResultName": "expenses",
          "cachedResultUrl": "https://docs.google.com/spreadsheets/d/1OMETcHXyTC9nXsYGxIrF6vY5zvgX1j0oyJu8aSeXtGs/edit?usp=drivesdk"
        },
        "sheetName": {
          "__rl": true,
          "value": "gid=0",
          "mode": "list",
          "cachedResultName": "Hoja 1",
          "cachedResultUrl": "https://docs.google.com/spreadsheets/d/1OMETcHXyTC9nXsYGxIrF6vY5zvgX1j0oyJu8aSeXtGs/edit#gid=0"
        },
        "columns": {
          "mappingMode": "defineBelow",
          "value": {
            "category": "={{ $json.category }}",
            "amount": "={{ $json.amount }}",
            "description": "={{ $json.description }}",
            "date": "={{ $json.date }}"
          },
          "matchingColumns": [],
          "schema": [
            {
              "id": "category",
              "displayName": "category",
              "required": false,
              "defaultMatch": false,
              "display": true,
              "type": "string",
              "canBeUsedToMatch": true
            },
            {
              "id": "amount",
              "displayName": "amount",
              "required": false,
              "defaultMatch": false,
              "display": true,
              "type": "string",
              "canBeUsedToMatch": true
            },
            {
              "id": "description",
              "displayName": "description",
              "required": false,
              "defaultMatch": false,
              "display": true,
              "type": "string",
              "canBeUsedToMatch": true
            },
            {
              "id": "date",
              "displayName": "date",
              "required": false,
              "defaultMatch": false,
              "display": true,
              "type": "string",
              "canBeUsedToMatch": true
            }
          ],
          "attemptToConvertTypes": false,
          "convertFieldsToString": false
        },
        "options": {}
      },
      "type": "n8n-nodes-base.googleSheets",
      "typeVersion": 4.7,
      "position": [
        320,
        0
      ],
      "id": "891197d7-c9d3-459d-a0b3-30024f4f167a",
      "name": "Append row in sheet",
      "credentials": {
        "googleSheetsOAuth2Api": {
          "id": "8J3hgRHtKauxjZ4z",
          "name": "Google Sheets account"
        }
      }
    },
    {
      "parameters": {
        "chatId": "={{ $('Telegram Trigger').item.json.message.chat.id }}",
        "text": "=✅ Registrado: {{ $json.category }} - ${{ $json.amount }} ({{ $json.description }})",
        "additionalFields": {}
      },
      "type": "n8n-nodes-base.telegram",
      "typeVersion": 1.2,
      "position": [
        480,
        0
      ],
      "id": "31f6a611-e664-4c73-8939-5c6b82e3bad9",
      "name": "Send a text message",
      "webhookId": "41bad2f9-4d99-4659-82f4-351a427df0b1",
      "credentials": {
        "telegramApi": {
          "id": "9a9khWbBWIX0H3bA",
          "name": "Telegram account"
        }
      }
    }
  ],
  "pinData": {},
  "connections": {
    "Telegram Trigger": {
      "main": [
        [
          {
            "node": "Code in JavaScript",
            "type": "main",
            "index": 0
          }
        ]
      ]
    },
    "Code in JavaScript": {
      "main": [
        [
          {
            "node": "Append row in sheet",
            "type": "main",
            "index": 0
          }
        ]
      ]
    },
    "Append row in sheet": {
      "main": [
        [
          {
            "node": "Send a text message",
            "type": "main",
            "index": 0
          }
        ]
      ]
    }
  },
  "active": true,
  "settings": {
    "executionOrder": "v1",
    "binaryMode": "separate"
  },
  "versionId": "1b81d5b5-c563-4d5c-bb57-4148397ae4ff",
  "meta": {
    "templateCredsSetupCompleted": true,
    "instanceId": "e189374ce1761aa87bc2ea4ff7ef08e183716f26beef1cd6f02cb74d3242134b"
  },
  "nodeGroups": [],
  "id": "L2CZJ2pXJ8XMNcyc",
  "tags": []
}
