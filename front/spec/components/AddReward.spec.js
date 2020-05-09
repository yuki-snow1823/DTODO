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
localVue.use(Vuetify)

describe('components/AddReward.vueのテスト', () => {
  let wrapper
  let vuetify
  let userStore
  let currentUser1

  beforeEach(() => {
    wrapper = mount(AddReward, {
      propsData: {
        reward: {
          title: "hoge",
          point: 1
        }
      },
      localVue,
      store: userStore,
      vuetify,
      mocks: {
        $store: {
          state: {
          }
        }
      }
    })
    vuetify = new Vuetify()
  })
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

  describe('フォームに関するテスト', () => {

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
