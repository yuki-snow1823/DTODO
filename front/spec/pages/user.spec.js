import Vuetify from 'vuetify'
import Vuex from 'vuex'
import user from '@/pages/user'
import {
  mount,
  createLocalVue
} from '@vue/test-utils'
import * as store from '@/store'

const localVue = createLocalVue()
localVue.use(Vuex)
localVue.use(Vuetify)

describe('pages/user.vueのテスト', () => {
  let wrapper
  let vuetify
  let userStore
  let currentUser1

  beforeEach(() => {
    wrapper = mount(user, {
      propsData: {
        reward: {
          title: "hoge",
          point: 1
        }
      },
      localVue,
      store: userStore,
      vuetify,
      mocks: {
        $store: {
          state: {}
        }
      }
    })
    vuetify = new Vuetify()
  })
  userStore = new Vuex.Store(store)
  currentUser1 = {
    user: {
      experience_point: 0
    },
    todos: [],
    rewards: [],
    untilPercentage: null,
    untilLevel: null,
  }
  userStore.replaceState({
    currentUser: currentUser1
  })

  describe('画面に関するテスト', () => {

    test("正しい値をセットしてボタンを押した場合、TODOが追加されること", () => {
      wrapper.find('input[type="text"]').setValue(1)
      wrapper.find('#todo-title').
      setValue("test title")
      wrapper.find('.todo-btn').trigger('click')
      expect(wrapper.find('.todo-title')).toBe(true)
    })

  })
})
