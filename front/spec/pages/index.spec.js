import Index from "./../../pages/index.vue";
import Vuex from 'vuex'
import { mount, createLocalVue } from '@vue/test-utils'
import * as indexStore from './../../store'
// @だとうまく読み込めなかったため、直接相対パスを指定しています。

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

    test('ログインしているときに、新規登録フォームが表示されない',() => {
      expect(wrapper.contains('#index-signup')).toBe(true)
      // ログインしている時という書き方が不明
    })
  })
  
})
