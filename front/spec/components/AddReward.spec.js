import Vuetify from 'vuetify'
import Vuex from 'vuex'
import AddReward from '@/components/AddReward'
import {
  mount,
  createLocalVue
} from '@vue/test-utils'
import * as store from '@/store'

const localVue = createLocalVue()
localVue.use(Vuex)

describe('components/AddReward.vueのテスト', () => {
  let wrapper
  let vuetify
  let userStore
  let currentUser1

  beforeEach(() => {
    wrapper = mount(AddReward, {
      localVue,
      store: userStore,
      vuetify,
    })
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
    userStore.replaceState({
      currentUser: currentUser1
    })
  })

// 以下のテストを行う際は、v-test-utilsとvuetifyの未解決のバグがあるため、AddReward.vueのv-formとv-hoverをコメントアウトしてください。

  describe('フォームに関するテスト', () => {
  test(`登録ボタンクリックでhandleSubmitが呼ばれること`, () => {
    const mock = jest.fn()
    wrapper.setMethods({
      handleSubmit: mock
    })
      console.log(store)
    wrapper.find('.reward-btn').trigger('click')
    expect(mock).toHaveBeenCalled()
  })

  test("フォームにタスクポイントがセットされること", () => {
    wrapper.find('input[type="text"]').setValue(1) 
    expect(wrapper.vm.number).toBe("1")
  })

  test("フォームにタイトルがセットされること", () => {
    wrapper.find('#reward-title').setValue("test title") 
    expect(wrapper.vm.title).toBe("test title")
  })

  test("親コンポーネントにイベントが渡せること", () => {
    wrapper.vm.$emit('submit')
    expect(wrapper.emitted().submit).toBeTruthy()
  })
  })
})
