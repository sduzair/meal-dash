export interface Subscription {
  id: number;
  starts_at: string;
  ends_at: string;
  created_at: string;
  deleted_at: string;
  is_deleted: boolean;
  mealplan_id: number;
}
