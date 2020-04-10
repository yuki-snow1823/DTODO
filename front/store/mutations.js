const mutations = {
  setUser(state, payload) {
    state.currentUser = payload
  },
  setLoading(state, payload) {
    state.loading = payload
  },
  setNotice(state, payload) {
    state.notification = payload
  },
  setError(state, payload) {
    state.errors = [...state.errors, payload]
  },
  clearErrors(state, _) {
    state.errors = []
  }
}

export default mutations
