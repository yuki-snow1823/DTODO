import Vue from 'vue'
import Vuetify from 'vuetify'
import Vuex from 'vuex'
import AddTodo from '@/components/AddTodo.vue'

import {
  mount,
  createLocalVue
} from '@vue/test-utils'

import index from '@/store/index'
import _ from 'lodash'

const localVue = createLocalVue()
localVue.use(Vuex)
localVue.use(Vuetify)

describe('components/AddTodo.vueのテスト', () => {
  let wrapper
  let vuetify
  let store

  beforeEach(() => {
    vuetify = new Vuetify(),
      store = new Vuex.Store(_.cloneDeep(index)),
      wrapper = mount(AddTodo, {
        vuetify,
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
        store
      })
  })


  describe('フォームに関するテスト', () => {
    test(`登録ボタンクリックでTODOが追加されること`, () => {
      // v-selectが指定できないので、このような形になっています。
      wrapper.find('input[type="text"]').setValue(1)
      wrapper.find('#todo-title').setValue("test title")
      wrapper.find('.todo-btn').trigger('click')
      console.log(store)
      expect(store.state.currentUser.todos.length).toBe(1)
      // expect(store.getters['messages'].length).not.toBe(0)
    })

    test("フォームにタスクポイントがセットされること", () => {
      wrapper.find('input[type="text"]').setValue(1)
      expect(wrapper.vm.todo.point).toBe("1")
    })
  })

  // test("フォームにタイトルがセットされること", () => {
  //   wrapper.find('#todo-title').setValue("test title")
  //   expect(wrapper.vm.title).toBe("test title")
  // })

  test("親コンポーネントにイベントが渡せること", () => {
    wrapper.vm.$emit('submit')
    expect(wrapper.emitted().submit).toBeTruthy()
  })
})
