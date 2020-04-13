import AddTodo from "@/components/AddTodo";
import Vuex from 'vuex'
import { mount, createLocalVue } from '@vue/test-utils'
import * as store from '@/store'

const localVue = createLocalVue()
localVue.use(Vuex)

describe('components/AddTodo.vue', () => {
  let wrapper
  beforeEach(() => {
    wrapper = mount(AddTodo, {
      store: store,
      localVue
    })
  })

  describe('template', () => {
    test('入力フォームが存在すること', () => {
      expect(wrapper.contains('v-text-field')).toBe(true)
      expect(wrapper.contains('.todo-btn')).toBe(true)
    })

    // describe('フォームの操作', () => {
    //   beforeEach(() => {
    //     wrapper.find('input[type="text"]').setValue('this title')
    //   })

    //   test('dataに入力が反映されること', () => {
    //     expect(wrapper.vm.todoForm.title).toBe('this title')
    //   })

    //   test('ボタンクリックでhandleAddTodoが呼ばれること', () => {
    //     const mock = jest.fn()
    //     wrapper.setMethods({
    //       handleAddTodo: mock
    //     })
    //     wrapper.find('button').trigger('click')
    //     expect(mock).toBeCalled()
    //   })
    })
  })
// })
