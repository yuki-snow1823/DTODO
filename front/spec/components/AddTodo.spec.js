import AddTodo from '@/components/AddTodo'
import {
  mount,
  createLocalVue
} from '@vue/test-utils'
import Vuex from 'vuex';
import * as store from '@/store'

let wrapper

const localVue = createLocalVue();
localVue.use(Vuex);

beforeEach(() => {
  wrapper = mount(AddTodo, {
    propsData: {
      todo: {
        title: "",
        point: null
      }
    },
    store: store,
    localVue
  })
})

describe('DOMイベントのテスト', () => {

  it('Testの詳細', () => {
    const hundleSubmit = jest.fn()

    wrapper.setMethods({
      hundleSubmit
    })

    wrapper.find('.todo-btn').trigger('click')
    expect(hundleSubmit).toBeCalled()
  })
})
