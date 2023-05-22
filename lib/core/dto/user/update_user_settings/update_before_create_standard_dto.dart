/*import { Field, InputType } from "@nestjs/graphql"
import { IsOptional, ValidateNested } from "class-validator";

@InputType()
export class UpdateBeforeCreateStandardInput {
  @Field(() => BeforeCreateStandardGroupchatSettings)
  @IsOptional()
  @ValidateNested()
  groupchatSettings: BeforeCreateStandardGroupchatSettings

  @Field(() => BeforeCreateStandardPrivateEventSettings)
  @IsOptional()
  @ValidateNested()
  privateEventSettings: BeforeCreateStandardPrivateEventSettings
}*/