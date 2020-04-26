const state = {
  currentUser: {
    user: {
      experience_point: 0
    },
    todo: {
      point: "",
      title: "",
    },
    reward: {
      point: "",
      title: "",
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
