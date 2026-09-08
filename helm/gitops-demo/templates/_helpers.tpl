{{- define "gitops-demo.name" -}}
gitops-demo
{{- end }}

{{- define "gitops-demo.fullname" -}}
{{ include "gitops-demo.name" . }}
{{- end }}
