import 'package:app/vo/goal/goals.dart';
import 'package:app/vo/outcome/outcome.dart';
import 'package:app/vo/outcome/outcome_goal.dart';
import 'package:app/vo/outcome/outcome_sub_goal.dart';

class OutcomeCreatorUtil
{
  static Outcome createOutcomeFromGoals(Goals goals)
  {
    List<OutcomeGoal> outcomeGoals = [];

    for(int i = 0; i < goals.elements.length; i++)
    {
      List<OutcomeSubGoal> handlungsziele = [];
      List<OutcomeSubGoal> massnahmenziele = [];
      
      for(int j = 0; j < goals.elements[i].handlungsziele.length; j++)
      {
        OutcomeSubGoal handlungsziel = OutcomeSubGoal(text: goals.elements[i].handlungsziele[j].text,
                                                      success: 50);
        
        handlungsziele.add(handlungsziel);
      }

      for(int j = 0; j < goals.elements[i].massnahmenziele.length; j++)
      {
        OutcomeSubGoal massnahmenziel = OutcomeSubGoal(text: goals.elements[i].massnahmenziele[j].text,
                                                       success: 50);
      
        massnahmenziele.add(massnahmenziel);
      }

      outcomeGoals.add(OutcomeGoal(text: goals.elements[i].text,
                                   success: 50,
                                   handlungsziele: handlungsziele,
                                   massnahmenziele: massnahmenziele));
    }

    return Outcome(elements: outcomeGoals);
  }
}
