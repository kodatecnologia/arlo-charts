{{/*
Expand the name of the chart.
*/}}
{{- define "helperfunc.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "helperfunc.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "helperfunc.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "helperfunc.labels" -}}
helm.sh/chart: {{ include "helperfunc.chart" . }}
{{ include "helperfunc.selectorLabels" . }}
app.kubernetes.io/version: {{ .Values.image.tag | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "helperfunc.selectorLabels" -}}
app.kubernetes.io/name: {{ include "helperfunc.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "helperfunc.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "helperfunc.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Host address prepare
*/}}
{{- define "helperfunc.hostaddr" -}}
{{- printf "Host(`%s`)" . }}
{{- end }}

{{/*
Create the host list to use in ingressroute
*/}}
{{- define "helperfunc.hostsList" -}}
{{- $hosts := list -}}
{{- range $item := . -}}
{{- $hosts = append $hosts (include "helperfunc.hostaddr" $item) -}}
{{- end -}}
{{- printf (join " || " $hosts) }}
{{- end -}}

{{- define "helperfunc.pathPrefix" -}}
{{- $path := . -}}
{{- printf "PathPrefix(`%s`)" $path -}}
{{- end }}








