const mutations = {
  setUser(state, payload) {
    state.currentUser = payload
  },
  setLoading(state, payload) {
    state.loading = payload
  },
  setNotice(state, payload) {
    state.notification = payload
  }
}

export default mutations
