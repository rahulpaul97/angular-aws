import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

const appRoutes: Routes = [
  { path: 'dashboard', loadChildren: () => import('./dashboard/dashboard-module').then(m => m.DashboardModule) },
  { path: 'about', loadChildren: () => import('./about/about-module').then(m => m.AboutModule) },
  { path: '**', redirectTo: 'dashboard', pathMatch: 'full' }
];

@NgModule({
  imports: [RouterModule.forRoot(appRoutes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
