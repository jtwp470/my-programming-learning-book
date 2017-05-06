# Tutorial Redux
See the [documentation](http://redux.js.org/docs/basics/)

## Redux Three Principles
Reduxは以下の3つの基礎原理の元に記述されている。

### Single source of truth (ソースは1つだけ)
アプリケーション全体の状態は1つのストアの1つのオブジェクトツリーに保存される。

* ユニバーサルアプリケーションが作りやすくなる。
* デバックも楽。開発が楽になる。

### State is read-only (状態は読み取り専用)
状態を変更する唯一の方法は、何かが起こったのかを記述するオブジェクトを生成することである。

### Changes are made with pure functions (変更は純粋な関数で書かれる)
状態ツリーがアクションによってどのように変更されるかを指定するためには、純粋なreducerを書けばよい。

Reducerとは純粋な関数であり、引数として前の状態と1つのアクションを受けとり次の状態を返すものである。

## Basics
### Actions
Actionはアプリケーションからストアにデータを送信する情報のペイロードである。

### Reducer
Actionはどのようなことが起きるかということを記述したが、どのようにアプリケーションの状態が変更されるかということに関しては指定していない。

今回の場合は次のような状態を保存するということにする。

```json
{
  visibilityFilter: 'SHOW_ALL',
  todos: [
    {
      text: 'Consider using Redux',
      completed: true,
    },
    {
      text: 'Keep all state in a single tree',
      completed: false
    }
  ]
}
```

#### アクションの取り扱い方
Reducerは純粋な関数であり、前の状態と1つのアクションを引数にとり、次の状態を返す。

Reducerは純粋なものであるため、以下の行為はReducer内部の処理では行われるべきではない。

* 引数を変化させる
* API呼び出しやルーティングなどの副作用を引き起こすものを実行する
* 純粋でない関数を呼び出す。(例: `Data.now()`, `Math.random()`)

### Store
前の章では、「何が引き起こされるのか」を表すアクションとそれらのActionによって状態が変更されるReducerを定義した。
Storeとはそれらを結びつけるオブジェクトである。Storeには次のような責任がある。

* アプリケーションの状態を保持すること
* `getState()` を経由して状態にアクセスすること
* `dispatch(action)` を経由して状態を更新すること
* `subscribe(listener)` を経由してリスナーを登録すること
* `subscribe(listener)` から返る関数を経由してリスナーの登録解除を処理すること
