const state = {
  currentUser: {
    user: {
      experience_point: 0
    },
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
