# Why Do We Need a Grafana Datasource Provisioning File?

## 1. Manual Datasource Setup
Normally, when Grafana starts (`http://localhost:3000`), you need to **manually add a datasource**:
- Go to: Settings → Data Sources → "Add data source"
- Select *Jaeger*
- Enter URL: `http://jaeger:16686`

This process must be repeated manually every time a new Grafana instance is created.

---

## 2. Automatic Provisioning
With the `grafana/provisioning/datasources/jaeger.yaml` file, Grafana:
- **Automatically registers the datasource** when the container starts
- Eliminates the need for manual setup
- Follows the Infrastructure as Code (IaC) principle, keeping configuration consistent and version-controlled

---

## 3. Example: jaeger.yaml
```yaml
apiVersion: 1

datasources:
  - name: Jaeger
    type: jaeger
    access: proxy
    url: http://jaeger:16686
    isDefault: true
```

- `name: Jaeger` → The datasource name inside Grafana  
- `type: jaeger` → The datasource type  
- `url: http://jaeger:16686` → URL of the Jaeger service  
- `isDefault: true` → Sets it as the default datasource  

---

## 4. Conclusion
- **With the file:** Grafana starts with Jaeger datasource preconfigured  
- **Without the file:** You need to manually configure the datasource each time  
