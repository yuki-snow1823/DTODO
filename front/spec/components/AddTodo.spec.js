import AddTodo from '@/components/AddTodo'
import {
  mount
} from '@vue/test-utils'
import Vuex from 'vuex';

let wrapper
// let store

// const localVue = createLocalVue();
// localVue.use(Vuex);

beforeEach(() => {
  wrapper = mount(AddTodo, {
    propsData: {
      todo: {
        title: "",
        point: null
      }
    },
    mocks: {
      $store: {
        state: {
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
      },
    },
  })
})

describe('DOMイベントのテスト', () => {

  it('Testの詳細', () => {
    // wrapper.find('.todo-btn').trigger('click')
    expect (wrapper.find('errors')).toBeTruthy()
  })
})
