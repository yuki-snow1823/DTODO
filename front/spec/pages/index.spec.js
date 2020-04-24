import Index from "@/pages/index.vue";
import Vuex from 'vuex'
import {
  mount,
  createLocalVue
} from '@vue/test-utils'
import * as indexStore from '@/store'

const localVue = createLocalVue()
localVue.use(Vuex)

describe('pages/index.vue', () => {
  let wrapper
  let store
  beforeEach(() => {
    store = new Vuex.Store(indexStore)
    wrapper = mount(Index, {
      store: store,
      localVue
    })
  })

  describe('表示に関するテスト', () => {
    test('タイトルが存在すること', () => {
      expect(wrapper.contains('.index-title')).toBe(true)
    })

    test('ログインしているときに、新規登録フォームが表示されない', () => {
    })

    test('ログインしているときに、ページ下部のログインボタンと新規登録ボタンが表示されない', () => {
      expect(wrapper.find('#index-signup').exists()).toBe(false)
    })
  })

})
