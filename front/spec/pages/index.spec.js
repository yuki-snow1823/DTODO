import index from "@/pages/index";
import Vuex from 'vuex'
import {
  mount,
  createLocalVue
} from '@vue/test-utils'

const localVue = createLocalVue()
localVue.use(Vuex)

describe('pages/index.vue', () => {
  let wrapper
  beforeEach(() => {
    wrapper = mount(index, {
      index: index,
      localVue
    })
  })

  describe('template', () => {
    test('タイトルが存在すること', () => {
      expect(wrapper.contains('.index-explain')).toBe(true)
    })
  })
  
})
