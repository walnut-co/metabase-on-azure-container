using './main.bicep'

param serviceBusName = 'your-service-bus-service-name'
param serviceBusAuthName = 'your-service-bus-service-sas-name'
param queueNames = [
  'queue-1'
  'queue-2'
]
param authRules = [
  'Listen'
  'Send'
]
