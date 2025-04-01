<template>
  <div class="desktop-app">
    <!-- Sidebar Navigation -->
    <aside class="app-sidebar">
      <div class="sidebar-header">
        <h2 class="app-logo">
          <span class="logo-icon">🔍</span>
          <span class="logo-text">Pesquisa</span>
        </h2>
      </div>
      <nav class="sidebar-nav">
        <ul>
          <li class="nav-item active">
            <span class="nav-icon">🏠</span>
            <span class="nav-text">Dashboard</span>
          </li>
        </ul>
      </nav>
    </aside>

    <!-- Main Content Area -->
    <main class="app-main">
      <!-- Top Bar -->
      <header class="app-topbar">
        <div class="search-container">
          <input
            v-model="searchTerm"
            @keyup.enter="performSearch"
            placeholder="Pesquisar no banco de dados..."
            class="search-input"
          />
          <button @click="performSearch" class="search-btn">
            <span v-if="!isLoading">Buscar</span>
            <div v-else class="loading-spinner"></div>
          </button>
        </div>
        <div class="user-profile">
          <span class="user-avatar">👤</span>
          <span class="user-name">Admin</span>
        </div>
      </header>

      <!-- Content Section -->
      <section class="content-section">
        <!-- Results Overview -->

        <div class="stats-container">
          <div class="stat-card">
            <div class="stat-value">{{ results?.length ?? 0 }}</div>
            <div class="stat-label">Resultados</div>
          </div>
          <div class="stat-card">
            <div class="stat-value">{{ searchTerm ? searchTerm.length : 0 }}</div>
            <div class="stat-label">Termo</div>
          </div>
          <div class="stat-card">
            <div class="stat-value">MySQL</div>
            <div class="stat-label">Database</div>
          </div>
        </div>

        <!-- Results Table -->
        <div class="results-container">
          <div class="table-header">
            <h3>Resultados da Busca</h3>
            <div class="table-actions">
              <button class="action-btn export-btn">Exportar CSV</button>
              <button class="action-btn refresh-btn" @click="performSearch">
                Atualizar
              </button>
            </div>
          </div>

          <div v-if="error" class="error-message">
            <span class="error-icon">⚠️</span>
            {{ error }}
          </div>

          <div v-if="results.length > 0" class="results-table">
            <table>
              <thead>
                <tr>
                  <th>ID</th>
                  <th>Conteúdo</th>
                  <th>Ações</th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="item in results" :key="item.id">
                  <td class="id-cell">{{ item.id }}</td>
                  <td class="content-cell">{{ item.texto }}</td>
                  <td class="actions-cell">
                    <button class="table-btn view-btn">Visualizar</button>
                    <button class="table-btn edit-btn">Editar</button>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>

          <div v-else-if="searched && !isLoading" class="empty-state">
            <div class="empty-icon">🔍</div>
            <h4>Nenhum resultado encontrado</h4>
            <p>Tente ajustar seus termos de busca</p>
          </div>
        </div>
      </section>
    </main>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import axios from 'axios'

const searchTerm = ref('')
const results = ref([])
const isLoading = ref(false)
const error = ref('')
const searched = ref(false)


const performSearch = async () => {
  try {
    isLoading.value = true
    error.value = ''
    results.value = [] // Reset antes de nova busca

    const response = await axios.get('/api/buscar/', {
      params: { q: searchTerm.value.trim() }
    })

    results.value = response.data?.resultados || []
    searched.value = true

  } catch (err) {
    error.value = 'Erro na busca: ' + (err.response?.data?.error || err.message)
    results.value = []
  } finally {
    isLoading.value = false
  }
}
</script>

<style scoped>
/* Base Styles */
.desktop-app {
  display: flex;
  min-height: 100vh;
  font-family: 'Segoe UI', system-ui, sans-serif;
  background-color: #f8fafc;
}

/* Sidebar Styles */
.app-sidebar {
  width: 240px;
  background: linear-gradient(180deg, #1e293b, #0f172a);
  color: white;
  padding: 1.5rem 0;
  box-shadow: 2px 0 10px rgba(0, 0, 0, 0.1);
}

.sidebar-header {
  padding: 0 1.5rem 1.5rem;
  border-bottom: 1px solid #334155;
}

.app-logo {
  display: flex;
  align-items: center;
  gap: 0.75rem;
  font-size: 1.25rem;
  font-weight: 600;
}

.logo-icon {
  font-size: 1.5rem;
}

.sidebar-nav {
  padding: 1.5rem 0;
}

.nav-item {
  display: flex;
  align-items: center;
  gap: 0.75rem;
  padding: 0.75rem 1.5rem;
  cursor: pointer;
  transition: all 0.2s ease;
}

.nav-item:hover {
  background-color: #334155;
}

.nav-item.active {
  background-color: #3b82f6;
}

.nav-icon {
  font-size: 1.1rem;
}

/* Main Content Styles */
.app-main {
  flex: 1;
  display: flex;
  flex-direction: column;
}

.app-topbar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 1rem 2rem;
  background-color: white;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
}

.search-container {
  display: flex;
  gap: 0.75rem;
  width: 500px;
}

.search-input {
  flex: 1;
  padding: 0.75rem 1rem;
  border: 1px solid #e2e8f0;
  border-radius: 6px;
  font-size: 0.95rem;
  transition: all 0.2s ease;
}

.search-input:focus {
  outline: none;
  border-color: #3b82f6;
  box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.2);
}

.search-btn {
  padding: 0 1.5rem;
  background-color: #3b82f6;
  color: white;
  border: none;
  border-radius: 6px;
  font-weight: 500;
  cursor: pointer;
  transition: all 0.2s ease;
}

.search-btn:hover {
  background-color: #2563eb;
}

.loading-spinner {
  width: 20px;
  height: 20px;
  border: 3px solid rgba(255, 255, 255, 0.3);
  border-top-color: white;
  border-radius: 50%;
  animation: spin 1s linear infinite;
}

.user-profile {
  display: flex;
  align-items: center;
  gap: 0.75rem;
}

.user-avatar {
  width: 36px;
  height: 36px;
  background-color: #e2e8f0;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #64748b;
}

/* Content Section */
.content-section {
  padding: 2rem;
  flex: 1;
}

.stats-container {
  display: flex;
  gap: 1.5rem;
  margin-bottom: 2rem;
}

.stat-card {
  flex: 1;
  background-color: white;
  border-radius: 8px;
  padding: 1.5rem;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
}

.stat-value {
  font-size: 2rem;
  font-weight: 600;
  color: #1e293b;
  margin-bottom: 0.5rem;
}

.stat-label {
  color: #64748b;
  font-size: 0.9rem;
}

/* Results Table */
.results-container {
  background-color: white;
  border-radius: 8px;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
  overflow: hidden;
}

.table-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 1.25rem 1.5rem;
  border-bottom: 1px solid #e2e8f0;
}

.table-actions {
  display: flex;
  gap: 0.75rem;
}

.action-btn {
  padding: 0.5rem 1rem;
  border-radius: 4px;
  font-size: 0.85rem;
  font-weight: 500;
  cursor: pointer;
  transition: all 0.2s ease;
}

.export-btn {
  background-color: #f1f5f9;
  color: #334155;
  border: 1px solid #e2e8f0;
}

.export-btn:hover {
  background-color: #e2e8f0;
}

.refresh-btn {
  background-color: #3b82f6;
  color: white;
  border: none;
}

.refresh-btn:hover {
  background-color: #2563eb;
}

.error-message {
  padding: 1rem 1.5rem;
  background-color: #fee2e2;
  color: #dc2626;
  display: flex;
  align-items: center;
  gap: 0.5rem;
}

.results-table {
  overflow-x: auto;
}

table {
  width: 100%;
  border-collapse: collapse;
}

th {
  text-align: left;
  padding: 1rem 1.5rem;
  background-color: #f8fafc;
  color: #64748b;
  font-weight: 500;
  font-size: 0.85rem;
  text-transform: uppercase;
  letter-spacing: 0.05em;
}

td {
  padding: 1rem 1.5rem;
  border-bottom: 1px solid #e2e8f0;
  color: #334155;
}

.id-cell {
  font-family: monospace;
  color: #64748b;
  font-size: 0.9rem;
}

.content-cell {
  max-width: 500px;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.actions-cell {
  display: flex;
  gap: 0.5rem;
}

.table-btn {
  padding: 0.35rem 0.75rem;
  border-radius: 4px;
  font-size: 0.8rem;
  cursor: pointer;
  transition: all 0.2s ease;
}

.view-btn {
  background-color: #e0f2fe;
  color: #0369a1;
  border: none;
}

.view-btn:hover {
  background-color: #bae6fd;
}

.edit-btn {
  background-color: #ede9fe;
  color: #7c3aed;
  border: none;
}

.edit-btn:hover {
  background-color: #ddd6fe;
}

.empty-state {
  padding: 3rem;
  text-align: center;
  color: #64748b;
}

.empty-icon {
  font-size: 3rem;
  margin-bottom: 1rem;
  opacity: 0.5;
}

/* Animations */
@keyframes spin {
  to { transform: rotate(360deg); }
}
</style>
