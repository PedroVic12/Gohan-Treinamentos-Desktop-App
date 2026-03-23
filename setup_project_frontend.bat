@echo off
echo ================================================
echo Criando estrutura do projeto Treinos React...
echo ================================================

REM ---- Criar pastas ----
mkdir public
mkdir src
mkdir src\components
mkdir src\utils

echo Pastas criadas com sucesso.

REM ---- Criar index.html ----
echo Criando public/index.html...
(
echo ^<!DOCTYPE html^>
echo ^<html lang="pt-br"^>
echo ^<head^>
echo     ^<meta charset="UTF-8" /^>
echo     ^<title>Treinos</title^>
echo     ^<link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500" rel="stylesheet" /^>
echo ^</head^>
echo ^<body^>
echo     ^<div id="root"^>^</div^>
echo     ^<script src="bundle.js"^>^</script^>
echo ^</body^>
echo ^</html^>
) > public\index.html

REM ---- Criar App.jsx ----
echo Criando App.jsx...
(
echo import React from "react";
echo import ImportExport from "./components/ImportExport";
echo import TrainingSelector from "./components/TrainingSelector";
echo import Dashboard from "./components/Dashboard";
echo
echo export default function App() {
echo   return (
echo     ^<div style={{ padding: 20 }}^>
echo       ^<h1^>Treinos - Sistema de Acompanhamento^</h1^>
echo       ^<ImportExport /^>
echo       ^<TrainingSelector /^>
echo       ^<Dashboard /^>
echo     ^</div^>
echo   );
echo }
) > src\App.jsx

REM ---- Criar componentes ----
echo Criando componentes...

REM ImportExport.jsx
(
echo import React from "react";
echo import { parseExcel } from "../utils/excelParser";
echo import { save } from "../utils/storage";
echo
echo export default function ImportExport({ onLoad }) {
echo   const handleImport = (e) => {
echo     const file = e.target.files[0];
echo     parseExcel(file, (data) => {
echo       save("training_data", data);
echo       if (onLoad) onLoad(data);
echo     });
echo   };
echo
echo   return (
echo     ^<div^>
echo       ^<input type="file" onChange={handleImport} /^>
echo     ^</div^>
echo   );
echo }
) > src\components\ImportExport.jsx

REM TrainingSelector.jsx
(
echo import React from "react";
echo
echo export default function TrainingSelector() {
echo   return (
echo     ^<div style={{ marginTop: 20 }}^>
echo       ^<h2^>Treino do Dia^</h2^>
echo       ^<p^>Selecione ou deixe o sistema escolher automaticamente.^</p^>
echo     ^</div^>
echo   );
echo }
) > src\components\TrainingSelector.jsx

REM TrainingTable.jsx
(
echo import React from "react";
echo
echo export default function TrainingTable({ data }) {
echo   return (
echo     ^<div^>
echo       ^<h3^>Tabela de Exercícios^</h3^>
echo       ^<p^>Renderização da planilha aqui.^</p^>
echo     ^</div^>
echo   );
echo }
) > src\components\TrainingTable.jsx

REM WorkoutChecklist.jsx
(
echo import React from "react";
echo import Checkbox from "@material-ui/core/Checkbox";
echo
echo export default function WorkoutChecklist() {
echo   return (
echo     ^<div^>
echo       ^<p^>Checklist das séries aqui.^</p^>
echo     ^</div^>
echo   );
echo }
) > src\components\WorkoutChecklist.jsx

REM RestTimerModal.jsx
(
echo import React from "react";
echo
echo export default function RestTimerModal() {
echo   return (
echo     ^<div^>
echo       ^<p^>Timer de descanso aqui.^</p^>
echo     ^</div^>
echo   );
echo }
) > src\components\RestTimerModal.jsx

REM Dashboard.jsx
(
echo import React from "react";
echo
echo export default function Dashboard() {
echo   return (
echo     ^<div style={{ marginTop: 20 }}^>
echo       ^<h2^>Dashboard Semanal / 28 Dias^</h2^>
echo       ^<p^>Progresso será exibido aqui.^</p^>
echo     ^</div^>
echo   );
echo }
) > src\components\Dashboard.jsx

REM ---- Criar utils ----
echo Criando utils...

REM excelParser.js
(
echo import * as XLSX from "xlsx";
echo
echo export function parseExcel(file, callback) {
echo   const reader = new FileReader();
echo   reader.onload = (e) => {
echo     const data = new Uint8Array(e.target.result);
echo     const workbook = XLSX.read(data, { type: "array" });
echo     const sheets = {};
echo     workbook.SheetNames.forEach(name => {
echo       sheets[name] = XLSX.utils.sheet_to_json(workbook.Sheets[name], { defval: "" });
echo     });
echo     callback(sheets);
echo   };
echo   reader.readAsArrayBuffer(file);
echo }
) > src\utils\excelParser.js

REM storage.js
(
echo export const save = (key, value) =>
echo   localStorage.setItem(key, JSON.stringify(value));
echo
echo export const load = (key, fallback) => {
echo   const v = localStorage.getItem(key);
echo   return v ? JSON.parse(v) : fallback;
echo };
) > src\utils\storage.js

echo ================================================
echo Projeto configurado com sucesso!
echo Diretórios e arquivos criados.
echo ================================================
pause