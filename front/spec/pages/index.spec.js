import Index from "./../../pages/index.vue";
import Vuex from 'vuex'
import { mount, createLocalVue } from '@vue/test-utils'
import * as indexStore from './../../store'

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

  describe('template', () => {
    test('タイトルが存在すること', () => {
      expect(wrapper.contains('.index-explain')).toBe(true)
    })
  })
  
})
