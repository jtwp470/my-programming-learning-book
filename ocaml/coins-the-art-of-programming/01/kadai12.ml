(* 課題1.2 時間の変換 *)
let minite2time time = 
  let oneday = 60 * 24 in
  let day = time / oneday in 
  let hour = (time - (time / oneday) * oneday) / 60 in
  let min = time - (day * oneday + hour * 60) in
  (day, hour, min)

let tuple2time (day, hour, min) =
  day * 24 * 60 + hour * 60 + min

let timeSum ((day1, hour1, time1), (day2, hour2, time2)) =
  minite2time (tuple2time(day1, hour1, time1) + tuple2time(day2, hour2, time2))
