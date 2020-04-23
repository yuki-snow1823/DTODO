// ライブラリ
import Vue from 'vue'
import Vuetify from 'vuetify'
import Vuex from 'vuex'
// コンポーネント
import AddTodo from '@/components/AddTodo'
// ユーティリティ
import {
  mount,
  createLocalVue
} from '@vue/test-utils'
//　ストア
import * as store from '@/store'

const localVue = createLocalVue()
localVue.use(Vuex)

describe('components/AddTodo.vueのテスト', () => {
  let wrapper
  let vuetify
  let userStore
  let currentUser1

  beforeEach(() => {
    wrapper = mount(AddTodo)
    vuetify = new Vuetify()
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
  })

  test('ボタンクリックでhandleSubmitが呼ばれること', () => {
    const wrapper = mount(AddTodo, {
      localVue,
      store: userStore,
      vuetify,
    })
    userStore.replaceState({
      currentUser: currentUser1
    })
    const mock = jest.fn()
    wrapper.setMethods({
      handleSubmit: mock
    })
    wrapper.find('.todo-btn').trigger('click')
    expect(mock).toHaveBeenCalled()
  })
})
