const state = {
  currentUser: {
    user: {},
    todos: [],
    rewards: [],
    untilPercentage: null,
    untilLevel: null,
  },
  loading: false,
  notification: {
    status: false,
    message: ""
  },
  errors: []
}

export default state
