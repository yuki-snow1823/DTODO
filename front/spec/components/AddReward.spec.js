// ここのテストはstateがなぜかないとエラーが出る

// ライブラリ
import Vue from 'vue'
import Vuetify from 'vuetify'
import Vuex from 'vuex'
// コンポーネント
import AddReward from '@/components/AddReward'
// ユーティリティ
import {
  mount,
  createLocalVue
} from '@vue/test-utils'
//　ストア
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

  test(`登録ボタンクリックでhandleSubmitが呼ばれること
  (※このテストを行う際は、v-formとv-hoverをコメントアウトしてください/vue-utils未対応のバグ）`, () => {
    const mock = jest.fn()
    wrapper.setMethods({
      handleSubmit: mock
    })
      console.log(store)
    wrapper.find('.reward-btn').trigger('click')
    expect(mock).toHaveBeenCalled()
  })

  test("フォームにタスクポイントがセットされること", () => {
    wrapper.find('input[type="text"]').setValue(1) //　pointの部分（idやクラス指定がなぜかできない）
    expect(wrapper.vm.number).toBe("1")
  })

  // test("フォームにタイトルがセットされること", () => {
  //   wrapper.find('#input-52').setValue("test title") //　titleの部分（idやクラス指定がなぜかできない）：質問する
  //   expect(wrapper.vm.title).toBe("1")
  // })

  test("親コンポーネントにイベントが渡せること", () => {
    wrapper.vm.$emit('submit')
    expect(wrapper.emitted().submit).toBeTruthy()
  })
})
