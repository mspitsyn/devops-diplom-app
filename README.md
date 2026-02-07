# devops-diplom-app  
Тестовое приложение содержит статичную `HTML-страницу` и `Dockerfile` с nginx, который будет отдавать статические данные html-страницы.
GitHub Actions. В файле [ci-cd.yaml](.github/workflows/ci-cd.yaml) настроено:  
- При любом коммите в репозиторий с тестовым приложением происходит сборка и отправка в регистр Docker образа.  
- При создании тега (например, v1.0.0) происходит сборка и отправка с соответствующим label в регистри, а также деплой соответствующего Docker образа в кластер Kubernetes.

### Как это работает:
1. Коммит в ветку main (без тега):
```bash
git commit -am "fix deployment logic"
git push origin main
```  
Запускается только build-and-push  

Образ помечается как mspitsyn/devops-diplom-app:20241217-abc123

**Deploy НЕ запускается**

2. Создание тега:
```bash
git tag v1.0.13
git push origin v1.0.13
```  
Запускаются обе jobs: **build-and-push** и **deploy**

Образ помечается как *mspitsyn/devops-diplom-app:v1.0.13*

Приложение деплоится в Kubernetes

3. Коммит с тегом (альтернативный способ):
```bash
git commit -am "release v1.0.14"
git tag v1.0.14
git push origin main --tags
```  
При пуше в main запустится build-and-push с SHA-тегом

При пуше тега v1.0.14 запустится build-and-push и deploy с версионным тегом