<template>
  <div>

    <v-tour name="myTour" :steps="steps" :callbacks="callbacks">
      <template slot-scope="tour">
        <transition name="fade">
          <!-- 警告が出ますが問題ありません -->
          <v-step v-if="tour.currentStep === index" v-for="(step, index) of tour.steps" :key="index" :step="step"
            :previous-step="tour.previousStep" :next-step="tour.nextStep" :stop="tour.stop" :is-first="tour.isFirst"
            :is-last="tour.isLast" :labels="tour.labels">
            <template v-if="tour.currentStep === 1">
              <div>
                <button @click="tour.previousStep" class="btn btn-primary">Previous step</button>
                <button @click="tour.nextStep" class="btn btn-primary">Next step</button>
              </div>
            </template>

          </v-step>
        </transition>
      </template>
    </v-tour>
  </div>
</template>

<script>
  import axios from "@/plugins/axios";
  export default {
    name: 'my-tour',
    data() {
      return {
        steps: [{
            target: '#v-step-0',
            header: {
              title: 'TODOの追加'
            },
            content: `まず、ここでTODOを登録しましょう。<br>TPは「タスクポイント」の略称です。<br>
            TODOを達成した時にもらえるポイントなので、大変なTODOほど大きな数のTPを設定しましょう。<br>
            <strong>TP「1」のTODOを登録したら次に進んでください。</strong>`,
            params: {
              placement: 'top'
            },
          },
          {
            target: '#v-step-1',
            header: {
              title: 'TODOの一覧'
            },
            params: {
              placement: 'bottom'
            },
            content: 'ハートのアイコンで達成、鉛筆のアイコンで編集、ゴミ箱のアイコンで削除ができます。<br><strong>ハートのアイコンを押して、達成したら次に進みましょう。</strong>'
          },
          {
            target: '#v-step-2',
            content: 'タスクポイントと経験値が増えました。<br>TODOを達成する度、あなたのレベルはアップします。<br>最大のレベル10を目指して毎日のTODOに取り組みましょう。<br>',
            params: {
              placement: 'bottom'
            }
          },
          {
            target: '#v-step-3',
            header: {
              title: 'メニューの一覧'
            },
            content: '貯まったタスクポイントはごほうびを解放するために使えます。<br>三本線のアイコンをクリックしてメニューを開き、ごほうびページにいってみましょう。<br>先にfinishを押してください。',
            params: {
              placement: 'top'
            }
          },
        ],
        callbacks: {
          onPreviousStep: this.myCustomPreviousStepCallback,
          onNextStep: this.myCustomNextStepCallback,
          onStop: this.myCustomOnStopCallback,
        }
      }
    },
    mounted: function () {
      this.$tours['myTour'].start()
      this.callbacks.onStop = () => {
        document.querySelector('#v-step-0').scrollIntoView({
          behavior: 'smooth'
        })
      }
    },
    methods: {
      nextStep() {
        this.$tours['myTour'].nextStep()
      },
      showLastStep() {
        this.$tours['myTour'].currentStep = this.steps.length - 1
      },
      myCustomPreviousStepCallback(currentStep) {
        console.log('[Vue Tour] A custom previousStep callback has been called on step ' + (currentStep + 1))
      },
      myCustomNextStepCallback(currentStep) {
        console.log('[Vue Tour] A custom nextStep callback has been called on step ' + (currentStep + 1))
        if (currentStep === 1) {
          console.log('[Vue Tour] A custom nextStep callback has been called from step 2 to step 3')
          console.log(this.callbacks)
        }
      },
    }
  }
</script>

<style scoped>
  .fade-enter-active,
  .fade-leave-active {
    transition: opacity .5s;
  }

  .fade-enter,
  .fade-leave-to {
    opacity: 0;
  }
</style>
