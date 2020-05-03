import AddTodo from '@/components/AddTodo'
import {
  mount
} from '@vue/test-utils'


let wrapper

beforeEach(() => {
  wrapper = mount(AddTodo)
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
