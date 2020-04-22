import Vuex from 'vuex'
import {
  mount,
  createLocalVue
} from '@vue/test-utils'
import * as store from '@/store'

import AddTodo from '@/components/AddTodo'

const localVue = createLocalVue()
localVue.use(Vuex)


describe('components/AddTodo.vueのテスト', () => {
  let wrapper
  let userStore // スコープ
  let currentUser1 

  beforeEach(() => {
    userStore = new Vuex.Store(store)
    currentUser1 = {
      user: {
        experience_point: 0
      },
      todos: [],
      rewards: [],
      untilPercentage: null,
      untilLevel: null,
    },
    wrapper = mount(AddTodo, {
      store: userStore,
      localVue
    })
    userStore.replaceState({ currentUser: currentUser1 })
  })

  describe('template', () => {
    test('入力フォームが存在すること', () => {
      expect(wrapper.contains('.todo-btn')).toBe(true)
    })
  })

  describe('フォームの操作に関するテスト', () => {
    // beforeEach(() => {
    //   // wrapper.find('input[type="select"]').setValue("1")
    //   wrapper.find('.text').setValue('this title')
    // })

    test('ボタンクリックでtestが呼ばれること', () => {
      const mock = jest.fn()
      wrapper.setMethods({
        test: mock
      })
      wrapper.find('.test').trigger('click')
      expect(mock).toHaveBeenCalled()
    })

  })
})
