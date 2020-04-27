import Vue from 'vue'
import Vuetify from 'vuetify'
import Vuex from 'vuex'
import AddTodo from '@/components/AddTodo.vue'

import {
  mount,
  createLocalVue
} from '@vue/test-utils'

const localVue = createLocalVue()
localVue.use(Vuex)
localVue.use(Vuetify)

describe('components/AddTodo.vueのテスト', () => {
  let wrapper

  beforeEach(() => {
    wrapper = mount(AddTodo, {
      propsData: {
        todo: {
          title: "hoge",
          point: 1
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
      localVue,
    })
  })

  describe('フォームに関するテスト', () => {
    test(`登録ボタンクリックでhandleSubmitが呼ばれること`, () => {
      const mock = jest.fn()
      wrapper.setMethods({
        handleSubmit: mock
      })
      wrapper.find('.todo-btn').trigger('click')
      expect(mock).toHaveBeenCalled()
    })

    test("フォームにタスクポイントがセットされること", () => {
      wrapper.find('input[type="text"]').setValue(1)
      expect(wrapper.vm.todo.point).toBe("1")
    })
  })

    test("フォームにタイトルがセットされること", () => {
      wrapper.find('#todo-title').setValue("test title")
      expect(wrapper.vm.title).toBe("test title")
    })

    test("親コンポーネントにイベントが渡せること", () => {
      wrapper.vm.$emit('submit')
      expect(wrapper.emitted().submit).toBeTruthy()
    })
})
